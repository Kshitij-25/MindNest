"""Wellness program schemas (camelCase)."""
from __future__ import annotations

from datetime import datetime

from pydantic import Field

from app.schemas.common import CamelModel


class LessonCreate(CamelModel):
    title: str = Field(min_length=1, max_length=200)
    content: str = ""
    exercise: str = ""
    journal_prompt: str = ""
    habit_recommendation: str = ""
    order_index: int = Field(default=0, ge=0)


class LessonOut(CamelModel):
    id: str
    program_id: str
    order_index: int
    title: str
    content: str = ""
    exercise: str = ""
    journal_prompt: str = ""
    habit_recommendation: str = ""
    created_at: datetime


class ProgramCreate(CamelModel):
    title: str = Field(min_length=1, max_length=200)
    description: str = ""
    category: str = ""


class ProgramUpdate(CamelModel):
    title: str | None = Field(default=None, max_length=200)
    description: str | None = None
    category: str | None = None
    status: str | None = Field(default=None, description="published | draft")


class ProgramOut(CamelModel):
    id: str
    author_professional_id: str
    title: str
    description: str = ""
    category: str = ""
    status: str
    lesson_count: int = 0
    created_at: datetime
    updated_at: datetime


class ProgramDetailOut(ProgramOut):
    lessons: list[LessonOut] = Field(default_factory=list)
