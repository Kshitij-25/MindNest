"""Booking endpoints (user side): create, list, cancel and review a session."""
from __future__ import annotations

from fastapi import APIRouter, Depends, status
from sqlalchemy.ext.asyncio import AsyncSession

from app.api.deps import get_current_user
from app.database import get_db
from app.models import BookingStatus, User
from app.schemas.booking import BookingCreate, BookingOut, ReviewCreate, ReviewOut
from app.services import booking_service, review_service

router = APIRouter(prefix="/bookings", tags=["Bookings"])


@router.post("", response_model=BookingOut, status_code=status.HTTP_201_CREATED)
async def create_booking(
    payload: BookingCreate,
    db: AsyncSession = Depends(get_db),
    user: User = Depends(get_current_user),
):
    booking = await booking_service.create(db, user, payload)
    return booking_service.to_out(booking, can_review=False)


@router.get("", response_model=list[BookingOut])
async def list_bookings(
    db: AsyncSession = Depends(get_db),
    user: User = Depends(get_current_user),
):
    return await booking_service.serialize_list(
        db, await booking_service.list_for_user(db, user)
    )


@router.get("/{booking_id}", response_model=BookingOut)
async def get_booking(
    booking_id: str,
    db: AsyncSession = Depends(get_db),
    user: User = Depends(get_current_user),
):
    booking = await booking_service.get_for_user(db, user, booking_id)
    reviewed = await booking_service.reviewed_ids(db, [booking.id])
    can_review = (
        booking.status == BookingStatus.COMPLETED and booking.id not in reviewed
    )
    return booking_service.to_out(booking, can_review=can_review)


@router.post("/{booking_id}/cancel", response_model=BookingOut)
async def cancel_booking(
    booking_id: str,
    db: AsyncSession = Depends(get_db),
    user: User = Depends(get_current_user),
):
    return booking_service.to_out(
        await booking_service.cancel_by_user(db, user, booking_id)
    )


@router.post(
    "/{booking_id}/review", response_model=ReviewOut, status_code=status.HTTP_201_CREATED
)
async def review_booking(
    booking_id: str,
    payload: ReviewCreate,
    db: AsyncSession = Depends(get_db),
    user: User = Depends(get_current_user),
):
    review = await review_service.create(db, user, booking_id, payload)
    return review_service.to_out(review)
