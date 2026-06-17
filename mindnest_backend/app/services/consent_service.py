"""User-controlled, per-scope data-sharing consent.

Consent is never implied — a professional sees a slice of a user's data only
when an explicit, currently-granted :class:`ConsentRecord` exists.
"""
from __future__ import annotations

from fastapi import HTTPException, status
from sqlalchemy import select

from app.core.utils import utcnow
from app.models import CONSENT_SCOPES, ConsentRecord


async def _get(db, user_id: str, professional_id: str, scope: str) -> ConsentRecord | None:
    res = await db.execute(
        select(ConsentRecord).where(
            ConsentRecord.user_id == user_id,
            ConsentRecord.professional_id == professional_id,
            ConsentRecord.scope == scope,
        )
    )
    return res.scalar_one_or_none()


async def grant(db, user, professional_id: str, scopes: list[str]) -> list[ConsentRecord]:
    if not scopes:
        raise HTTPException(status.HTTP_400_BAD_REQUEST, "No scopes provided")
    invalid = [s for s in scopes if s not in CONSENT_SCOPES]
    if invalid:
        raise HTTPException(
            status.HTTP_400_BAD_REQUEST, f"Unknown scope(s): {', '.join(invalid)}"
        )

    out: list[ConsentRecord] = []
    for scope in dict.fromkeys(scopes):  # de-dupe, preserve order
        rec = await _get(db, user.id, professional_id, scope)
        if rec is None:
            rec = ConsentRecord(
                user_id=user.id, professional_id=professional_id, scope=scope
            )
            db.add(rec)
        rec.granted = True
        rec.granted_at = utcnow()
        rec.revoked_at = None
        out.append(rec)

    await db.commit()
    for rec in out:
        await db.refresh(rec)
    return out


async def revoke(db, user, professional_id: str, scope: str) -> ConsentRecord:
    rec = await _get(db, user.id, professional_id, scope)
    if rec is None or not rec.granted:
        raise HTTPException(
            status.HTTP_404_NOT_FOUND, "No active consent for that scope"
        )
    rec.granted = False
    rec.revoked_at = utcnow()
    await db.commit()
    await db.refresh(rec)
    return rec


async def list_for_user(db, user) -> list[ConsentRecord]:
    res = await db.execute(
        select(ConsentRecord)
        .where(ConsentRecord.user_id == user.id)
        .order_by(ConsentRecord.created_at.desc())
    )
    return list(res.scalars().all())


async def active_scopes(db, user_id: str, professional_id: str) -> set[str]:
    res = await db.execute(
        select(ConsentRecord.scope).where(
            ConsentRecord.user_id == user_id,
            ConsentRecord.professional_id == professional_id,
            ConsentRecord.granted.is_(True),
        )
    )
    return {s for (s,) in res.all()}


def to_out(r: ConsentRecord) -> dict:
    return {
        "id": r.id,
        "professional_id": r.professional_id,
        "scope": r.scope,
        "granted": r.granted,
        "granted_at": r.granted_at,
        "revoked_at": r.revoked_at,
        "created_at": r.created_at,
    }
