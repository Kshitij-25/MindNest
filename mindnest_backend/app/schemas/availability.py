"""Availability schemas (camelCase)."""
from __future__ import annotations

from datetime import date, datetime

from pydantic import Field

from app.schemas.common import CamelModel


class AvailabilityRuleCreate(CamelModel):
    weekday: int = Field(ge=0, le=6, description="0=Mon .. 6=Sun")
    start_minute: int = Field(ge=0, le=1440, description="minutes from midnight (UTC)")
    end_minute: int = Field(ge=0, le=1440)
    slot_minutes: int = Field(default=60, ge=15, le=240)


class AvailabilityRuleOut(CamelModel):
    id: str
    professional_id: str
    weekday: int
    start_minute: int
    end_minute: int
    slot_minutes: int
    created_at: datetime


class AvailabilityExceptionCreate(CamelModel):
    date: date
    kind: str = Field(default="blocked", description="blocked | vacation")
    reason: str = ""


class AvailabilityExceptionOut(CamelModel):
    id: str
    professional_id: str
    date: date
    kind: str
    reason: str = ""
    created_at: datetime


class SlotOut(CamelModel):
    id: str
    professional_id: str
    start_time: datetime
    end_time: datetime
    available: bool
