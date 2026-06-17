"""Professional credential verification (submit + manual review)."""
from __future__ import annotations

from fastapi import HTTPException, status
from sqlalchemy import select

from app.core.utils import utcnow
from app.models import Professional, ProfessionalVerification, VerificationStatus

_REVIEW_STATUSES = {VerificationStatus.APPROVED, VerificationStatus.REJECTED}


async def submit(db, pro: Professional, payload) -> ProfessionalVerification:
    v = ProfessionalVerification(
        professional_id=pro.id,
        document_type=payload.document_type,
        document_url=payload.document_url,
        note=payload.note or "",
    )
    db.add(v)
    # A re-submission after rejection puts the profile back under review.
    if pro.verification_status == VerificationStatus.REJECTED:
        pro.verification_status = VerificationStatus.PENDING
    await db.commit()
    await db.refresh(v)
    return v


async def list_for_professional(db, pro: Professional) -> list[ProfessionalVerification]:
    res = await db.execute(
        select(ProfessionalVerification)
        .where(ProfessionalVerification.professional_id == pro.id)
        .order_by(ProfessionalVerification.created_at.desc())
    )
    return list(res.scalars().all())


async def review(
    db, verification_id: str, new_status: str, review_note: str
) -> ProfessionalVerification:
    if new_status not in _REVIEW_STATUSES:
        raise HTTPException(
            status.HTTP_400_BAD_REQUEST,
            "status must be 'approved' or 'rejected'",
        )
    res = await db.execute(
        select(ProfessionalVerification).where(
            ProfessionalVerification.id == verification_id
        )
    )
    v = res.scalar_one_or_none()
    if v is None:
        raise HTTPException(status.HTTP_404_NOT_FOUND, "Verification not found")

    v.status = new_status
    v.review_note = review_note or ""
    v.reviewed_at = utcnow()

    pres = await db.execute(
        select(Professional).where(Professional.id == v.professional_id)
    )
    pro = pres.scalar_one_or_none()
    if pro is not None:
        pro.verification_status = new_status

    await db.commit()
    await db.refresh(v)
    return v


def to_out(v: ProfessionalVerification) -> dict:
    return {
        "id": v.id,
        "professional_id": v.professional_id,
        "document_type": v.document_type,
        "document_url": v.document_url,
        "note": v.note,
        "status": v.status,
        "review_note": v.review_note,
        "reviewed_at": v.reviewed_at,
        "created_at": v.created_at,
    }
