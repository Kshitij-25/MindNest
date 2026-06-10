"""Camel-cased habit schemas."""
from __future__ import annotations

from datetime import date as _Date  # aliased: a field is named ``date`` below
from datetime import datetime

from pydantic import Field

from app.schemas.common import CamelModel


class HabitCreate(CamelModel):
    name: str = Field(min_length=1, max_length=120)
    kind: str = "custom"   # meditation|exercise|sleep|hydration|reading|custom
    cadence: str = "daily"  # daily|weekly
    target_dimension: str | None = None


class HabitUpdate(CamelModel):
    name: str | None = Field(default=None, max_length=120)
    kind: str | None = None
    cadence: str | None = None
    target_dimension: str | None = None
    active: bool | None = None


class HabitOut(CamelModel):
    id: str
    name: str
    kind: str
    cadence: str
    target_dimension: str | None = None
    active: bool
    created_at: datetime
    done_today: bool = False


class HabitLogRequest(CamelModel):
    date: _Date | None = None
    done: bool | None = True
    note: str | None = None


class HabitLogOut(CamelModel):
    id: str
    habit_id: str
    date: _Date
    done: bool
    note: str | None = None
    created_at: datetime


class HabitCorrelation(CamelModel):
    label: str
    dimension: str | None = None
    done_avg: float
    missed_avg: float
    delta: float
    insight: str


class HabitAnalyticsOut(CamelModel):
    habit_id: str
    name: str
    cadence: str
    completion_rate: float
    total_done: int
    current_streak: int
    longest_streak: int
    correlation: HabitCorrelation | None = None
