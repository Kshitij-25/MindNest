"""Camel-cased onboarding schemas.

Onboarding is a five-field intake that *seeds* the adaptive engine: the
fields are mapped to a dimension contribution, scored, and persisted as a
synthetic completed assessment + initial mood profile.
"""
from __future__ import annotations

from datetime import datetime
from typing import Any

from pydantic import Field

from app.schemas.common import CamelModel
from app.schemas.recommendation import RecommendationOut


class OnboardingRequest(CamelModel):
    mood: int = Field(ge=1, le=5, description="Overall mood right now (1 low … 5 great)")
    stress: int = Field(ge=0, le=10, description="Current stress level (0 none … 10 max)")
    sleep: int = Field(ge=1, le=5, description="Recent sleep quality (1 poor … 5 great)")
    anxiety: int | None = Field(default=None, ge=0, le=3, description="Optional anxiety (0 … 3)")
    goals: list[str] = Field(default_factory=list)
    focus_areas: list[str] = Field(default_factory=list)


class DimensionOut(CamelModel):
    dimension: str
    label: str
    score: float
    confidence: float
    elevated: bool


class OnboardingResultOut(CamelModel):
    """The initial emotional profile + first recommendations."""

    onboarded: bool
    assessment_id: str
    created_at: datetime
    overall_mood: str
    valence: float
    arousal: float
    confidence: float
    summary: str
    dimensions: list[DimensionOut] = Field(default_factory=list)
    top_emotions: list[dict[str, Any]] = Field(default_factory=list)
    derived: dict[str, Any] = Field(default_factory=dict)
    recommendations: list[RecommendationOut] = Field(default_factory=list)


class OnboardingStatusOut(CamelModel):
    onboarded: bool
    completed: bool
    goals: list[str] = Field(default_factory=list)
    focus_areas: list[str] = Field(default_factory=list)
