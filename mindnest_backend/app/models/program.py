"""Wellness programs authored by professionals (MVP 2, Phase B).

A program is a sequence of lessons, each of which can carry an exercise, a
journal prompt and a habit recommendation — tying expert content back into the
MVP 1 journaling / habit loops.
"""
from __future__ import annotations

from datetime import datetime

from sqlalchemy import DateTime, ForeignKey, Integer, String, Text
from sqlalchemy.orm import Mapped, mapped_column

from app.core.utils import new_id, utcnow
from app.database import Base


class ProgramStatus:
    PUBLISHED = "published"
    DRAFT = "draft"


class Program(Base):
    __tablename__ = "programs"

    id: Mapped[str] = mapped_column(String(32), primary_key=True, default=new_id)
    author_professional_id: Mapped[str] = mapped_column(
        ForeignKey("professionals.id", ondelete="CASCADE"), index=True
    )
    title: Mapped[str] = mapped_column(String(200))
    description: Mapped[str] = mapped_column(Text, default="")
    # Free-form category (often a specialization slug, e.g. "burnout").
    category: Mapped[str] = mapped_column(String(40), default="", index=True)
    status: Mapped[str] = mapped_column(
        String(16), default=ProgramStatus.PUBLISHED, index=True
    )
    created_at: Mapped[datetime] = mapped_column(DateTime, default=utcnow, index=True)
    updated_at: Mapped[datetime] = mapped_column(
        DateTime, default=utcnow, onupdate=utcnow
    )


class ProgramLesson(Base):
    __tablename__ = "program_lessons"

    id: Mapped[str] = mapped_column(String(32), primary_key=True, default=new_id)
    program_id: Mapped[str] = mapped_column(
        ForeignKey("programs.id", ondelete="CASCADE"), index=True
    )
    order_index: Mapped[int] = mapped_column(Integer, default=0)
    title: Mapped[str] = mapped_column(String(200))
    content: Mapped[str] = mapped_column(Text, default="")
    exercise: Mapped[str] = mapped_column(Text, default="")
    journal_prompt: Mapped[str] = mapped_column(Text, default="")
    habit_recommendation: Mapped[str] = mapped_column(Text, default="")
    created_at: Mapped[datetime] = mapped_column(DateTime, default=utcnow)
