"""Aggregate professional dashboard: profile, availability, bookings, clients,
reviews and basic analytics — assembled from the MVP 2 services."""
from __future__ import annotations

from sqlalchemy import select

from app.core.utils import utcnow
from app.models import Booking, BookingStatus
from app.services import (
    availability_service,
    booking_service,
    professional_service,
    review_service,
)

_UPCOMING_STATUSES = {BookingStatus.PENDING, BookingStatus.CONFIRMED}


async def dashboard(db, pro) -> dict:
    bres = await db.execute(
        select(Booking)
        .where(Booking.professional_id == pro.id)
        .order_by(Booking.scheduled_at.desc())
    )
    bookings = list(bres.scalars().all())

    by_status: dict[str, int] = {}
    for b in bookings:
        by_status[b.status] = by_status.get(b.status, 0) + 1

    now = utcnow()
    upcoming = sorted(
        (
            b
            for b in bookings
            if b.scheduled_at >= now and b.status in _UPCOMING_STATUSES
        ),
        key=lambda b: b.scheduled_at,
    )[:10]
    upcoming_out = await booking_service.serialize_list(db, upcoming)

    client_ids = {b.user_id for b in bookings}
    reviews = await review_service.list_for_professional(db, pro.id)
    open_slots = await availability_service.list_available(db, pro.id, ensure=False)

    total = len(bookings)
    completed = by_status.get(BookingStatus.COMPLETED, 0)

    return {
        "profile": professional_service.to_self_out(pro),
        "availability": {
            "upcoming_open_slots": len(open_slots),
            "next_available": open_slots[0].start_time if open_slots else None,
        },
        "bookings": {"by_status": by_status, "upcoming": upcoming_out},
        "clients": {"total": len(client_ids)},
        "reviews": {
            "average_rating": pro.rating,
            "count": pro.review_count,
            "recent": [review_service.to_out(r) for r in reviews[:5]],
        },
        "analytics": {
            "total_bookings": total,
            "completed": completed,
            "cancelled": by_status.get(BookingStatus.CANCELLED, 0),
            "completion_rate": round(completed / total, 2) if total else 0.0,
            "average_rating": pro.rating,
            "review_count": pro.review_count,
        },
    }
