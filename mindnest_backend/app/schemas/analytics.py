"""Camel-cased analytics schemas (emotional timeline + pattern detector)."""
from __future__ import annotations

from pydantic import Field

from app.schemas.common import CamelModel


class Driver(CamelModel):
    name: str
    count: int
    kind: str  # topic | factor


class TimelineChange(CamelModel):
    dimension: str
    label: str
    drift: float
    direction: str
    current: float
    improving: bool
    drivers: list[str] = Field(default_factory=list)
    note: str


class EmotionalTimelineOut(CamelModel):
    days: int
    changes: list[TimelineChange] = Field(default_factory=list)
    drivers: list[Driver] = Field(default_factory=list)


class PatternCard(CamelModel):
    title: str
    body: str
    kind: str          # trigger | behavior
    value: float
    topic_index: int
    color_key: str


class PatternsOut(CamelModel):
    days: int
    patterns: list[PatternCard] = Field(default_factory=list)
