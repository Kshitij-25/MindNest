from __future__ import annotations

from datetime import datetime
from typing import Any

from pydantic import BaseModel


class DimensionScore(BaseModel):
    dimension: str
    label: str
    score: float          # 0..100
    confidence: float     # 0..1
    elevated: bool        # is this a flagged/notable signal?


class MoodSummaryOut(BaseModel):
    assessment_id: str
    created_at: datetime
    overall_mood: str
    valence: float        # -100..100 (negative..positive)
    arousal: float        # 0..100 (calm..activated)
    confidence: float     # 0..1
    summary: str
    summary_source: str
    dimensions: list[DimensionScore]
    top_emotions: list[dict[str, Any]]
    derived: dict[str, Any]
    contradictions: list[dict[str, Any]]


class HistoryItem(BaseModel):
    assessment_id: str
    created_at: datetime
    overall_mood: str
    valence: float
    confidence: float
    top_emotions: list[dict[str, Any]]


class TrendPoint(BaseModel):
    created_at: datetime
    score: float
    confidence: float


class DimensionTrend(BaseModel):
    dimension: str
    label: str
    points: list[TrendPoint]
    current: float
    previous: float | None = None
    delta: float                 # current - previous
    direction: str               # "rising" | "falling" | "stable"
    drift: float                 # current - first (whole window)


class TrendsOut(BaseModel):
    days: int
    samples: int
    trends: list[DimensionTrend]


class InsightsOut(BaseModel):
    period_days: int
    samples: int
    headline: str
    insights: list[str]
    burnout_progression: dict[str, Any]
    generated_at: datetime
