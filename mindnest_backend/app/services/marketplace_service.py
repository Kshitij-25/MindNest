"""Marketplace: browse / filter / search verified professionals."""
from __future__ import annotations

from sqlalchemy import or_, select

from app.models import Professional, VerificationStatus
from app.services import availability_service, professional_service


def _base_query():
    """Only active, verified professionals are publicly listable."""
    return select(Professional).where(
        Professional.is_active.is_(True),
        Professional.verification_status == VerificationStatus.APPROVED,
    )


async def list_professionals(
    db,
    *,
    specialization: str | None = None,
    language: str | None = None,
    max_price: float | None = None,
    min_rating: float | None = None,
    query: str | None = None,
    limit: int = 50,
    offset: int = 0,
) -> list[dict]:
    stmt = _base_query()
    if max_price is not None:
        stmt = stmt.where(Professional.session_price <= max_price)
    if min_rating is not None:
        stmt = stmt.where(Professional.rating >= min_rating)
    if query:
        like = f"%{query.strip()}%"
        stmt = stmt.where(
            or_(Professional.name.ilike(like), Professional.bio.ilike(like))
        )
    stmt = stmt.order_by(Professional.rating.desc(), Professional.review_count.desc())

    res = await db.execute(stmt)
    pros = list(res.scalars().all())

    # JSON-list filters (specialization, language) are applied in Python so the
    # behaviour is identical on SQLite and Postgres.
    if specialization:
        pros = [p for p in pros if specialization in (p.specializations or [])]
    if language:
        lang = language.lower()
        pros = [
            p
            for p in pros
            if any(lang == str(x).lower() for x in (p.languages or []))
        ]

    sliced = pros[offset : offset + limit]
    return [professional_service.to_public_out(p) for p in sliced]


async def get_detail(db, professional_id: str) -> dict:
    pro = await professional_service.get(db, professional_id)
    return professional_service.to_public_out(pro)


async def availability(db, professional_id: str) -> list[dict]:
    # 404 if the professional doesn't exist / is inactive.
    await professional_service.get(db, professional_id)
    slots = await availability_service.list_available(db, professional_id)
    return [availability_service.slot_out(s) for s in slots]
