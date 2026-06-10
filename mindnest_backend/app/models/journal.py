from __future__ import annotations

from datetime import datetime

from sqlalchemy import JSON, Boolean, DateTime, ForeignKey, Integer, String, Text
from sqlalchemy.orm import Mapped, mapped_column, relationship

from app.core.utils import new_id, utcnow
from app.database import Base


class JournalAnalysisStatus:
    PENDING = "pending"
    READY = "ready"
    FAILED = "failed"
    DISABLED = "disabled"   # when the user turned off journal AI


class Journal(Base):
    """A journal entry. ``day``/``date``/``time`` are derived from ``created_at``."""

    __tablename__ = "journals"

    id: Mapped[str] = mapped_column(String(32), primary_key=True, default=new_id)
    user_id: Mapped[str] = mapped_column(
        ForeignKey("users.id", ondelete="CASCADE"), index=True
    )
    # free | guided | gratitude | reflection
    kind: Mapped[str] = mapped_column(String(20), default="free", index=True)
    prompt: Mapped[str | None] = mapped_column(Text, nullable=True)
    mood: Mapped[int] = mapped_column(Integer, default=3)   # 1..5
    title: Mapped[str] = mapped_column(String(200), default="")
    body: Mapped[str] = mapped_column(Text, default="")
    tags: Mapped[list] = mapped_column(JSON, default=list)
    draft: Mapped[bool] = mapped_column(Boolean, default=False, index=True)
    analysis_status: Mapped[str] = mapped_column(
        String(16), default=JournalAnalysisStatus.PENDING
    )
    created_at: Mapped[datetime] = mapped_column(DateTime, default=utcnow, index=True)
    updated_at: Mapped[datetime] = mapped_column(
        DateTime, default=utcnow, onupdate=utcnow
    )

    analysis: Mapped["JournalAnalysis | None"] = relationship(  # noqa: F821
        back_populates="journal", cascade="all, delete-orphan", uselist=False
    )
