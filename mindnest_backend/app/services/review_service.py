"""Reviews — one per completed booking; recomputes the professional's rating."""
from __future__ import annotations

from fastapi import HTTPException, status
from sqlalchemy import func, select

from app.models import Booking, BookingStatus, Professional, Review


async def create(db, user, booking_id: str, payload) -> Review:
    res = await db.execute(select(Booking).where(Booking.id == booking_id))
    booking = res.scalar_one_or_none()
    if booking is None or booking.user_id != user.id:
        raise HTTPException(status.HTTP_404_NOT_FOUND, "Booking not found")
    if booking.status != BookingStatus.COMPLETED:
        raise HTTPException(
            status.HTTP_409_CONFLICT, "You can only review a completed session"
        )
    existing = await db.execute(
        select(Review).where(Review.booking_id == booking_id)
    )
    if existing.scalar_one_or_none() is not None:
        raise HTTPException(
            status.HTTP_409_CONFLICT, "This session has already been reviewed"
        )

    review = Review(
        user_id=user.id,
        professional_id=booking.professional_id,
        booking_id=booking_id,
        rating=payload.rating,
        comment=payload.comment or "",
    )
    db.add(review)
    await db.flush()  # so the aggregate below includes this review
    await _recompute_rating(db, booking.professional_id)
    await db.commit()
    await db.refresh(review)
    return review


async def _recompute_rating(db, professional_id: str) -> None:
    res = await db.execute(
        select(func.count(), func.avg(Review.rating)).where(
            Review.professional_id == professional_id
        )
    )
    count, avg = res.one()
    pres = await db.execute(
        select(Professional).where(Professional.id == professional_id)
    )
    pro = pres.scalar_one_or_none()
    if pro is not None:
        pro.review_count = int(count or 0)
        pro.rating = round(float(avg or 0.0), 2)


async def list_for_professional(db, professional_id: str) -> list[Review]:
    res = await db.execute(
        select(Review)
        .where(Review.professional_id == professional_id)
        .order_by(Review.created_at.desc())
    )
    return list(res.scalars().all())


def to_out(r: Review) -> dict:
    return {
        "id": r.id,
        "user_id": r.user_id,
        "professional_id": r.professional_id,
        "booking_id": r.booking_id,
        "rating": r.rating,
        "comment": r.comment,
        "created_at": r.created_at,
    }
