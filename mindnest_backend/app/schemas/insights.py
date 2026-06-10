"""Camel-cased schemas for the windowed insight endpoints."""
from __future__ import annotations

from datetime import datetime

from pydantic import Field

from app.schemas.common import CamelModel


class BurnoutMove(CamelModel):
    first: float = 0.0
    last: float = 0.0
    delta: float = 0.0
    direction: str = "stable"


class InsightOut(CamelModel):
    scope: str
    period_key: str
    headline: str
    insights: list[str] = Field(default_factory=list)
    samples: int = 0
    burnout: BurnoutMove = Field(default_factory=BurnoutMove)
    generated_at: datetime
