"""Camel-cased emotional-memory schemas."""
from __future__ import annotations

from datetime import datetime

from pydantic import Field

from app.schemas.common import CamelModel


class MemoryHit(CamelModel):
    id: str
    kind: str
    ref_id: str | None = None
    summary: str = ""
    snippet: str = ""
    score: float
    created_at: datetime


class MemorySearchOut(CamelModel):
    query: str
    results: list[MemoryHit] = Field(default_factory=list)
