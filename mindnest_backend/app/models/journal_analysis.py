from __future__ import annotations

from datetime import datetime

from sqlalchemy import JSON, DateTime, ForeignKey, String, Text
from sqlalchemy.orm import Mapped, mapped_column, relationship

from app.core.utils import new_id, utcnow
from app.database import Base


class JournalAnalysis(Base):
    """Structured AI analysis of a journal entry (produced in the background)."""

    __tablename__ = "journal_analysis"

    id: Mapped[str] = mapped_column(String(32), primary_key=True, default=new_id)
    journal_id: Mapped[str] = mapped_column(
        ForeignKey("journals.id", ondelete="CASCADE"), unique=True, index=True
    )
    user_id: Mapped[str] = mapped_column(
        ForeignKey("users.id", ondelete="CASCADE"), index=True
    )
    emotion: Mapped[str | None] = mapped_column(String(32), nullable=True)
    dimensions: Mapped[dict] = mapped_column(JSON, default=dict)
    summary: Mapped[str] = mapped_column(Text, default="")
    topics: Mapped[list] = mapped_column(JSON, default=list)
    themes: Mapped[list] = mapped_column(JSON, default=list)
    stressors: Mapped[list] = mapped_column(JSON, default=list)
    wins: Mapped[list] = mapped_column(JSON, default=list)
    concerns: Mapped[list] = mapped_column(JSON, default=list)
    suggestions: Mapped[list] = mapped_column(JSON, default=list)
    sources: Mapped[list] = mapped_column(JSON, default=list)
    model: Mapped[str] = mapped_column(String(128), default="")
    created_at: Mapped[datetime] = mapped_column(DateTime, default=utcnow)

    journal: Mapped["Journal"] = relationship(back_populates="analysis")  # noqa: F821
