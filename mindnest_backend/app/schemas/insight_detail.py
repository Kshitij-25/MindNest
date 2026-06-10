"""Insight-detail payload (camelCase) — a deep-dive on one signal (currently
burnout): the metric + spark, contributing factors and related recommendations.
"""
from __future__ import annotations

from pydantic import Field

from app.schemas.common import CamelModel


class DetailFactor(CamelModel):
    label: str
    value: int          # 0..100
    color_key: str


class InsightDetailOut(CamelModel):
    type: str
    title: str
    kind: str
    icon: str
    color_key: str
    headline: str
    confidence: int
    band: str
    metric: int
    metric_label: str
    metric_delta: int
    spark: list[int] = Field(default_factory=list)
    factors: list[DetailFactor] = Field(default_factory=list)
    rec_ids: list[str] = Field(default_factory=list)
    context: str = ""
