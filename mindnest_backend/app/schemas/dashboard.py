"""Camel-cased dashboard aggregate (wellness-only)."""
from __future__ import annotations

from datetime import datetime
from typing import Any

from pydantic import Field

from app.schemas.common import CamelModel
from app.schemas.journal import JournalOut
from app.schemas.recommendation import RecommendationOut


class CurrentMood(CamelModel):
    level: int | None = None
    label: str
    valence: float = 0.0


class ProfileDimension(CamelModel):
    dimension: str
    label: str
    score: float
    elevated: bool


class EmotionalProfile(CamelModel):
    overall_mood: str
    valence: float
    confidence: float
    top_emotions: list[Any] = Field(default_factory=list)
    dimensions: list[ProfileDimension] = Field(default_factory=list)


class StreakBrief(CamelModel):
    current: int
    longest: int
    goal: int


class InsightCardBrief(CamelModel):
    headline: str = ""
    body: str = ""
    generated_at: datetime | None = None


class DashboardOut(CamelModel):
    display_name: str | None = None
    current_mood: CurrentMood
    emotional_profile: EmotionalProfile | None = None
    streak: StreakBrief
    weekly_trend: list[int] = Field(default_factory=list)
    latest_insight: InsightCardBrief | None = None
    recommendations: list[RecommendationOut] = Field(default_factory=list)
    recent_journal: JournalOut | None = None
