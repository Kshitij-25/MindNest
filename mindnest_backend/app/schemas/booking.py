"""Booking + review schemas (camelCase)."""
from __future__ import annotations

from datetime import datetime

from pydantic import Field, model_validator

from app.schemas.common import CamelModel


class BookingCreate(CamelModel):
    professional_id: str
    # Either book a generated slot by id, or pass an explicit time.
    slot_id: str | None = None
    scheduled_at: datetime | None = None
    duration: int = Field(default=60, ge=15, le=240)
    notes: str = ""

    @model_validator(mode="after")
    def _need_slot_or_time(self) -> "BookingCreate":
        if not self.slot_id and not self.scheduled_at:
            raise ValueError("Provide either slotId or scheduledAt.")
        return self


class BookingOut(CamelModel):
    id: str
    user_id: str
    professional_id: str
    slot_id: str | None = None
    scheduled_at: datetime
    duration: int
    status: str
    notes: str = ""
    can_review: bool = False
    created_at: datetime
    updated_at: datetime


class ReviewCreate(CamelModel):
    rating: int = Field(ge=1, le=5)
    comment: str = ""


class ReviewOut(CamelModel):
    id: str
    user_id: str
    professional_id: str
    booking_id: str
    rating: int
    comment: str = ""
    created_at: datetime
