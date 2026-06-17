"""Booking lifecycle: create → confirm → complete (or cancel).

A booking either consumes a generated availability slot (which is then marked
unavailable) or carries an explicit ``scheduled_at``. Cancelling frees the slot.
"""
from __future__ import annotations

from fastapi import HTTPException, status
from sqlalchemy import select

from app.models import (
    AvailabilitySlot,
    Booking,
    BookingStatus,
    Review,
)
from app.services import availability_service, professional_service

_CANCELLABLE = {BookingStatus.PENDING, BookingStatus.CONFIRMED}


async def create(db, user, payload) -> Booking:
    pro = await professional_service.get(db, payload.professional_id)

    slot = None
    scheduled_at = payload.scheduled_at
    duration = payload.duration

    if payload.slot_id:
        slot = await availability_service.get_slot(db, payload.slot_id)
        if slot is None or slot.professional_id != pro.id:
            raise HTTPException(status.HTTP_404_NOT_FOUND, "Slot not found")
        if not slot.available:
            raise HTTPException(
                status.HTTP_409_CONFLICT, "That slot is no longer available"
            )
        scheduled_at = slot.start_time
        duration = max(
            1, int((slot.end_time - slot.start_time).total_seconds() // 60)
        )

    if scheduled_at is None:
        raise HTTPException(
            status.HTTP_400_BAD_REQUEST, "scheduledAt or slotId is required"
        )

    booking = Booking(
        user_id=user.id,
        professional_id=pro.id,
        slot_id=slot.id if slot else None,
        scheduled_at=scheduled_at,
        duration=duration,
        status=BookingStatus.PENDING,
        notes=payload.notes or "",
    )
    db.add(booking)
    await db.flush()
    if slot is not None:
        slot.available = False
        slot.booking_id = booking.id
    await db.commit()
    await db.refresh(booking)
    return booking


# ---- listing / fetch ---------------------------------------------------------


async def list_for_user(db, user) -> list[Booking]:
    res = await db.execute(
        select(Booking)
        .where(Booking.user_id == user.id)
        .order_by(Booking.scheduled_at.desc())
    )
    return list(res.scalars().all())


async def list_for_professional(db, pro) -> list[Booking]:
    res = await db.execute(
        select(Booking)
        .where(Booking.professional_id == pro.id)
        .order_by(Booking.scheduled_at.desc())
    )
    return list(res.scalars().all())


async def get_for_user(db, user, booking_id: str) -> Booking:
    res = await db.execute(select(Booking).where(Booking.id == booking_id))
    b = res.scalar_one_or_none()
    if b is None or b.user_id != user.id:
        raise HTTPException(status.HTTP_404_NOT_FOUND, "Booking not found")
    return b


async def get_for_professional(db, pro, booking_id: str) -> Booking:
    res = await db.execute(select(Booking).where(Booking.id == booking_id))
    b = res.scalar_one_or_none()
    if b is None or b.professional_id != pro.id:
        raise HTTPException(status.HTTP_404_NOT_FOUND, "Booking not found")
    return b


# ---- transitions -------------------------------------------------------------


async def confirm(db, pro, booking_id: str) -> Booking:
    b = await get_for_professional(db, pro, booking_id)
    if b.status != BookingStatus.PENDING:
        raise HTTPException(
            status.HTTP_409_CONFLICT, f"Cannot confirm a {b.status} booking"
        )
    b.status = BookingStatus.CONFIRMED
    await db.commit()
    await db.refresh(b)
    return b


async def complete(db, pro, booking_id: str) -> Booking:
    b = await get_for_professional(db, pro, booking_id)
    if b.status != BookingStatus.CONFIRMED:
        raise HTTPException(
            status.HTTP_409_CONFLICT, f"Cannot complete a {b.status} booking"
        )
    b.status = BookingStatus.COMPLETED
    await db.commit()
    await db.refresh(b)
    return b


async def _cancel(db, booking: Booking) -> Booking:
    if booking.status not in _CANCELLABLE:
        raise HTTPException(
            status.HTTP_409_CONFLICT, f"Cannot cancel a {booking.status} booking"
        )
    booking.status = BookingStatus.CANCELLED
    await _free_slot(db, booking)
    await db.commit()
    await db.refresh(booking)
    return booking


async def cancel_by_user(db, user, booking_id: str) -> Booking:
    return await _cancel(db, await get_for_user(db, user, booking_id))


async def cancel_by_professional(db, pro, booking_id: str) -> Booking:
    return await _cancel(db, await get_for_professional(db, pro, booking_id))


async def _free_slot(db, booking: Booking) -> None:
    if not booking.slot_id:
        return
    res = await db.execute(
        select(AvailabilitySlot).where(AvailabilitySlot.id == booking.slot_id)
    )
    slot = res.scalar_one_or_none()
    if slot is not None:
        slot.available = True
        slot.booking_id = None


# ---- serialization -----------------------------------------------------------


async def reviewed_ids(db, booking_ids: list[str]) -> set[str]:
    if not booking_ids:
        return set()
    res = await db.execute(
        select(Review.booking_id).where(Review.booking_id.in_(booking_ids))
    )
    return {bid for (bid,) in res.all()}


def to_out(booking: Booking, *, can_review: bool = False) -> dict:
    return {
        "id": booking.id,
        "user_id": booking.user_id,
        "professional_id": booking.professional_id,
        "slot_id": booking.slot_id,
        "scheduled_at": booking.scheduled_at,
        "duration": booking.duration,
        "status": booking.status,
        "notes": booking.notes,
        "can_review": can_review,
        "created_at": booking.created_at,
        "updated_at": booking.updated_at,
    }


async def serialize_list(db, bookings: list[Booking]) -> list[dict]:
    """Serialize bookings, computing ``can_review`` in one batch query."""
    completed_ids = [
        b.id for b in bookings if b.status == BookingStatus.COMPLETED
    ]
    reviewed = await reviewed_ids(db, completed_ids)
    out = []
    for b in bookings:
        can_review = (
            b.status == BookingStatus.COMPLETED and b.id not in reviewed
        )
        out.append(to_out(b, can_review=can_review))
    return out
