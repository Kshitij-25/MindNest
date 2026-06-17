"""Professional auth (register / login / refresh / logout) + profile CRUD.

The professional identity space is fully separate from the user space: its own
table, its own refresh sessions (:class:`ProfessionalSession`) and tokens tagged
with ``actor="professional"`` so the two can never cross.
"""
from __future__ import annotations

from fastapi import HTTPException, status
from sqlalchemy import delete, select

from app.config import settings
from app.core.security import (
    create_actor_refresh_token,
    create_actor_token,
    decode_token,
    hash_password,
    verify_password,
)
from app.core.specializations import label as spec_label
from app.core.specializations import normalize as normalize_specs
from app.models import Professional, ProfessionalSession

ACTOR = "professional"

# Simple profile fields that update 1:1 from the patch payload.
_SIMPLE_FIELDS = (
    "name",
    "photo",
    "title",
    "languages",
    "experience_years",
    "bio",
    "education",
    "certifications",
    "session_price",
    "currency",
    "timezone",
)


# ---- auth --------------------------------------------------------------------


async def register(db, payload) -> Professional:
    existing = await db.execute(
        select(Professional).where(Professional.email == payload.email)
    )
    if existing.scalar_one_or_none() is not None:
        raise HTTPException(status.HTTP_409_CONFLICT, "Email already registered")
    pro = Professional(
        email=payload.email,
        hashed_password=hash_password(payload.password),
        name=payload.name,
        title=payload.title,
        specializations=normalize_specs(payload.specializations),
        languages=payload.languages or [],
        experience_years=payload.experience_years,
        bio=payload.bio or "",
        session_price=payload.session_price,
        currency=payload.currency or "USD",
        timezone=payload.timezone or "UTC",
    )
    db.add(pro)
    await db.commit()
    await db.refresh(pro)
    return pro


async def authenticate(db, email: str, password: str) -> Professional:
    res = await db.execute(
        select(Professional).where(Professional.email == email.lower())
    )
    pro = res.scalar_one_or_none()
    if pro is None or not verify_password(password, pro.hashed_password):
        raise HTTPException(
            status.HTTP_401_UNAUTHORIZED,
            "Incorrect email or password",
            headers={"WWW-Authenticate": "Bearer"},
        )
    if not pro.is_active:
        raise HTTPException(status.HTTP_401_UNAUTHORIZED, "Account is disabled")
    return pro


async def start_session(db, pro: Professional, device: str | None) -> str:
    sess = ProfessionalSession(
        professional_id=pro.id, device=(device or "")[:255] or None
    )
    db.add(sess)
    await db.commit()
    await db.refresh(sess)
    return sess.id


def issue_tokens(professional_id: str, session_id: str) -> dict:
    return {
        "access_token": create_actor_token(professional_id, ACTOR),
        "refresh_token": create_actor_refresh_token(professional_id, session_id, ACTOR),
        "expires_in_minutes": settings.ACCESS_TOKEN_EXPIRE_MINUTES,
    }


async def refresh(db, refresh_token: str) -> dict:
    claims = decode_token(refresh_token)
    if (
        not claims
        or claims.get("type") != "refresh"
        or claims.get("actor") != ACTOR
    ):
        raise HTTPException(status.HTTP_401_UNAUTHORIZED, "Invalid refresh token")
    jti, sub = claims.get("jti"), claims.get("sub")
    res = await db.execute(
        select(ProfessionalSession).where(ProfessionalSession.id == jti)
    )
    sess = res.scalar_one_or_none()
    if sess is None or sess.professional_id != sub:
        raise HTTPException(status.HTTP_401_UNAUTHORIZED, "Session no longer valid")
    return issue_tokens(sub, sess.id)


async def logout(db, refresh_token: str) -> None:
    claims = decode_token(refresh_token)
    if claims and claims.get("jti"):
        await db.execute(
            delete(ProfessionalSession).where(
                ProfessionalSession.id == claims["jti"]
            )
        )
        await db.commit()


# ---- profile -----------------------------------------------------------------


async def get(db, professional_id: str) -> Professional:
    res = await db.execute(
        select(Professional).where(Professional.id == professional_id)
    )
    pro = res.scalar_one_or_none()
    if pro is None or not pro.is_active:
        raise HTTPException(status.HTTP_404_NOT_FOUND, "Professional not found")
    return pro


async def update_profile(db, pro: Professional, payload) -> Professional:
    data = payload.model_dump(exclude_unset=True)
    if data.get("specializations") is not None:
        pro.specializations = normalize_specs(data.pop("specializations"))
    for field in _SIMPLE_FIELDS:
        if field in data and data[field] is not None:
            setattr(pro, field, data[field])
    await db.commit()
    await db.refresh(pro)
    return pro


# ---- serialization -----------------------------------------------------------


def to_public_out(p: Professional) -> dict:
    return {
        "id": p.id,
        "name": p.name,
        "photo": p.photo,
        "title": p.title,
        "specializations": p.specializations or [],
        "specialization_labels": [spec_label(s) for s in (p.specializations or [])],
        "languages": p.languages or [],
        "experience_years": p.experience_years,
        "bio": p.bio or "",
        "education": p.education or [],
        "certifications": p.certifications or [],
        "verification_status": p.verification_status,
        "rating": p.rating,
        "review_count": p.review_count,
        "session_price": p.session_price,
        "currency": p.currency,
        "timezone": p.timezone,
        "created_at": p.created_at,
    }


def to_self_out(p: Professional) -> dict:
    return {**to_public_out(p), "email": p.email, "is_active": p.is_active}
