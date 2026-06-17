"""Availability engine tables (MVP 2).

Three layers:

* :class:`AvailabilityRule`  — recurring weekly windows (the schedule).
* :class:`AvailabilityException` — blocked dates / vacations.
* :class:`AvailabilitySlot` — concrete, bookable time slots generated from the
  rules minus the exceptions minus already-booked slots.

Times are stored as naive UTC (matching the rest of MindNest — see
``core/utils.utcnow``); a professional's display ``timezone`` lives on the
:class:`~app.models.professional.Professional` row.
"""
from __future__ import annotations

from datetime import date, datetime

from sqlalchemy import (
    Boolean,
    Date,
    DateTime,
    ForeignKey,
    Integer,
    String,
)
from sqlalchemy.orm import Mapped, mapped_column

from app.core.utils import new_id, utcnow
from app.database import Base


class ExceptionKind:
    BLOCKED = "blocked"
    VACATION = "vacation"


class AvailabilityRule(Base):
    """A recurring weekly availability window for a professional."""

    __tablename__ = "availability_rules"

    id: Mapped[str] = mapped_column(String(32), primary_key=True, default=new_id)
    professional_id: Mapped[str] = mapped_column(
        ForeignKey("professionals.id", ondelete="CASCADE"), index=True
    )
    weekday: Mapped[int] = mapped_column(Integer)          # 0=Mon .. 6=Sun
    start_minute: Mapped[int] = mapped_column(Integer)     # minutes from midnight
    end_minute: Mapped[int] = mapped_column(Integer)
    slot_minutes: Mapped[int] = mapped_column(Integer, default=60)
    created_at: Mapped[datetime] = mapped_column(DateTime, default=utcnow)


class AvailabilityException(Base):
    """A blocked day or vacation that suppresses slot generation for a date."""

    __tablename__ = "availability_exceptions"

    id: Mapped[str] = mapped_column(String(32), primary_key=True, default=new_id)
    professional_id: Mapped[str] = mapped_column(
        ForeignKey("professionals.id", ondelete="CASCADE"), index=True
    )
    date: Mapped[date] = mapped_column(Date, index=True)
    kind: Mapped[str] = mapped_column(String(16), default=ExceptionKind.BLOCKED)
    reason: Mapped[str] = mapped_column(String(255), default="")
    created_at: Mapped[datetime] = mapped_column(DateTime, default=utcnow)


class AvailabilitySlot(Base):
    """A concrete bookable slot. ``available`` flips to False once booked."""

    __tablename__ = "availability_slots"

    id: Mapped[str] = mapped_column(String(32), primary_key=True, default=new_id)
    professional_id: Mapped[str] = mapped_column(
        ForeignKey("professionals.id", ondelete="CASCADE"), index=True
    )
    start_time: Mapped[datetime] = mapped_column(DateTime, index=True)
    end_time: Mapped[datetime] = mapped_column(DateTime)
    available: Mapped[bool] = mapped_column(Boolean, default=True, index=True)
    booking_id: Mapped[str | None] = mapped_column(String(32), nullable=True)
    created_at: Mapped[datetime] = mapped_column(DateTime, default=utcnow)
