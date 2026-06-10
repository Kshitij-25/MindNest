"""Wellness-score payload (camelCase) — a single 0–100 wellbeing index built
from the latest emotional profile, with the contributing signals + a short
trend spark for the home hero and the wellness-score detail screen."""
from __future__ import annotations

from pydantic import Field

from app.schemas.common import CamelModel


class WellnessSignal(CamelModel):
    key: str
    value: int          # 0..100 (higher = healthier)
    weight: str         # High | Med | Low
    icon: str


class WellnessScoreOut(CamelModel):
    score: int          # 0..100
    band: str           # Thriving | Balanced | Managing | Struggling
    trend: str          # up | down | flat
    weekly_change: int  # points vs the start of the window
    confidence: int     # 0..100
    signals: list[WellnessSignal] = Field(default_factory=list)
    spark: list[int] = Field(default_factory=list)
