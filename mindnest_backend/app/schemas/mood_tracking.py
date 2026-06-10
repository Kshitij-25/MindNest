"""Camel-cased schemas for the mood check-in slice."""
from __future__ import annotations

from datetime import date, datetime
from typing import Any

from pydantic import Field

from app.schemas.common import CamelModel


class CheckinRequest(CamelModel):
    level: int = Field(ge=1, le=5, description="Mood level (1 low … 5 great)")
    factors: list[str] = Field(default_factory=list)
    note: str = ""


class StreakOut(CamelModel):
    current: int
    longest: int
    goal: int
    last_checkin_date: date | None = None


class CheckinOut(CamelModel):
    id: str
    level: int
    factors: list[str] = Field(default_factory=list)
    note: str = ""
    created_at: datetime
    overall_mood: str
    valence: float
    top_emotions: list[Any] = Field(default_factory=list)
    streak: StreakOut


class FactorOut(CamelModel):
    key: str
    label: str
    polarity: str


class RecentMood(CamelModel):
    id: str
    level: int
    factors: list[str] = Field(default_factory=list)
    note: str = ""
    day_label: str
    clock_label: str
    relative_time: str
    created_at: datetime


class MoodHistoryOut(CamelModel):
    month_levels: list[int] = Field(default_factory=list)
    average: float
    trend_label: str
    recent: list[RecentMood] = Field(default_factory=list)


class CalendarDay(CamelModel):
    date: str
    day: int
    level: int | None = None
    has_entry: bool = False


class MoodCalendarOut(CamelModel):
    year: int
    month: int
    days: list[CalendarDay] = Field(default_factory=list)


class TrendPoint(CamelModel):
    created_at: datetime
    score: float
    confidence: float


class DimensionTrend(CamelModel):
    dimension: str
    label: str
    points: list[TrendPoint] = Field(default_factory=list)
    current: float
    previous: float | None = None
    delta: float
    direction: str
    drift: float


class MoodTrendsOut(CamelModel):
    days: int
    samples: int
    trends: list[DimensionTrend] = Field(default_factory=list)


class DistributionBin(CamelModel):
    level: int
    count: int


class InsightCard(CamelModel):
    title: str
    body: str
    topic_index: int
    color_key: str


class MoodInsightsOut(CamelModel):
    streak_days: int
    streak_goal: int
    average: float
    trend_label: str
    week: list[int] = Field(default_factory=list)
    month: list[int] = Field(default_factory=list)
    distribution: list[DistributionBin] = Field(default_factory=list)
    cards: list[InsightCard] = Field(default_factory=list)
