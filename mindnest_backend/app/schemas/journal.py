"""Camel-cased journal schemas."""
from __future__ import annotations

from datetime import datetime
from typing import Any

from pydantic import Field

from app.schemas.common import CamelModel

_KINDS = ("free", "guided", "gratitude", "reflection")


class JournalCreate(CamelModel):
    kind: str = "free"
    prompt: str | None = None
    mood: int = Field(default=3, ge=1, le=5)
    title: str = ""
    body: str = ""
    tags: list[str] = Field(default_factory=list)
    draft: bool = False


class JournalUpdate(CamelModel):
    kind: str | None = None
    prompt: str | None = None
    mood: int | None = Field(default=None, ge=1, le=5)
    title: str | None = None
    body: str | None = None
    tags: list[str] | None = None
    draft: bool | None = None


class JournalOut(CamelModel):
    id: str
    kind: str
    prompt: str | None = None
    mood: int
    title: str = ""
    body: str = ""
    tags: list[str] = Field(default_factory=list)
    draft: bool = False
    analysis_status: str
    created_at: datetime
    updated_at: datetime
    day_label: str
    clock_label: str
    relative_time: str


class TopicTag(CamelModel):
    slug: str
    name: str
    topic_index: int
    color_key: str


class JournalAnalysisOut(CamelModel):
    journal_id: str
    status: str
    ready: bool
    emotion: str | None = None
    dimensions: dict[str, Any] = Field(default_factory=dict)
    summary: str = ""
    topics: list[TopicTag] = Field(default_factory=list)
    themes: list[str] = Field(default_factory=list)
    stressors: list[str] = Field(default_factory=list)
    wins: list[str] = Field(default_factory=list)
    concerns: list[str] = Field(default_factory=list)
    suggestions: list[str] = Field(default_factory=list)
    sources: list[str] = Field(default_factory=list)
    model: str = ""
    created_at: datetime | None = None


class JournalPromptsOut(CamelModel):
    kind: str
    prompts: list[str] = Field(default_factory=list)
