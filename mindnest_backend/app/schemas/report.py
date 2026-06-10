"""Camel-cased weekly wellness report schemas."""
from __future__ import annotations

from datetime import datetime

from pydantic import Field

from app.schemas.analytics import PatternCard
from app.schemas.common import CamelModel


class ReportRange(CamelModel):
    start: str
    end: str


class ReportMood(CamelModel):
    average: float
    avg_level: int = 0
    avg_label: str = ""
    trend_label: str
    change: str = ""
    check_ins: int
    best_day: str = ""
    hardest_day: str = ""


class FollowThrough(CamelModel):
    accepted: int = 0
    completed: int = 0
    dismissed: int = 0


class TopicCount(CamelModel):
    topic: str
    count: int


class EmotionalChange(CamelModel):
    key: str
    delta: int


class WeeklyReportOut(CamelModel):
    period_key: str
    narrative: str = ""
    generated_at: datetime
    range: ReportRange
    mood: ReportMood
    journal_count: int = 0
    top_topics: list[TopicCount] = Field(default_factory=list)
    streak: int = 0
    habit_adherence: float = 0.0
    follow_through: FollowThrough = Field(default_factory=FollowThrough)
    patterns: list[PatternCard] = Field(default_factory=list)
    emotional_changes: list[EmotionalChange] = Field(default_factory=list)
    burnout_movement: int = 0
    growth_areas: list[str] = Field(default_factory=list)
    suggested_focus: str = ""
