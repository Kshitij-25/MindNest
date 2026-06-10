from __future__ import annotations

from datetime import datetime

from sqlalchemy import JSON, DateTime, Float, ForeignKey, String, Text
from sqlalchemy.orm import Mapped, mapped_column, relationship

from app.core.utils import new_id, utcnow
from app.database import Base


class MoodProfile(Base):
    """A snapshot of the user's emotional state at the end of one assessment."""

    __tablename__ = "mood_profiles"

    id: Mapped[str] = mapped_column(String(32), primary_key=True, default=new_id)
    user_id: Mapped[str] = mapped_column(
        ForeignKey("users.id", ondelete="CASCADE"), index=True
    )
    assessment_id: Mapped[str] = mapped_column(
        ForeignKey("assessments.id", ondelete="CASCADE"), unique=True, index=True
    )
    created_at: Mapped[datetime] = mapped_column(DateTime, default=utcnow, index=True)

    overall_mood: Mapped[str] = mapped_column(String(64))
    valence: Mapped[float] = mapped_column(Float, default=0.0)   # -100..100
    arousal: Mapped[float] = mapped_column(Float, default=0.0)   # 0..100
    confidence: Mapped[float] = mapped_column(Float, default=0.0)  # 0..1

    # dimension -> 0..100 score
    dimensions: Mapped[dict] = mapped_column(JSON, default=dict)
    # dimension -> 0..1 confidence
    dimension_confidence: Mapped[dict] = mapped_column(JSON, default=dict)
    # derived metrics (burnout_risk, emotional_fatigue, instability, ...)
    derived: Mapped[dict] = mapped_column(JSON, default=dict)
    # [{dimension, score}] sorted desc
    top_emotions: Mapped[list] = mapped_column(JSON, default=list)
    # detected contradictions
    contradictions: Mapped[list] = mapped_column(JSON, default=list)

    summary: Mapped[str] = mapped_column(Text, default="")
    # where the natural-language summary came from: "llm" | "template"
    summary_source: Mapped[str] = mapped_column(String(16), default="template")

    user: Mapped["User"] = relationship(back_populates="mood_profiles")  # noqa: F821
    assessment: Mapped["Assessment"] = relationship(  # noqa: F821
        back_populates="mood_profile"
    )


class EmotionalHistory(Base):
    """Normalized long-format history: one row per (assessment, dimension).

    This shape makes trend / drift SQL trivial and keeps mood charts fast.
    """

    __tablename__ = "emotional_history"

    id: Mapped[str] = mapped_column(String(32), primary_key=True, default=new_id)
    user_id: Mapped[str] = mapped_column(
        ForeignKey("users.id", ondelete="CASCADE"), index=True
    )
    assessment_id: Mapped[str] = mapped_column(
        ForeignKey("assessments.id", ondelete="CASCADE"), index=True
    )
    dimension: Mapped[str] = mapped_column(String(32), index=True)
    score: Mapped[float] = mapped_column(Float)
    confidence: Mapped[float] = mapped_column(Float, default=0.0)
    created_at: Mapped[datetime] = mapped_column(DateTime, default=utcnow, index=True)
