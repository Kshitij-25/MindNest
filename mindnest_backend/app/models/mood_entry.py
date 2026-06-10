from __future__ import annotations

from datetime import datetime

from sqlalchemy import JSON, DateTime, ForeignKey, Integer, String, Text
from sqlalchemy.orm import Mapped, mapped_column

from app.core.utils import new_id, utcnow
from app.database import Base


class MoodEntry(Base):
    """A daily mood check-in (the simple 1..5 + factors + note surface).

    Each check-in is also pushed through the scoring engine: ``dimension_deltas``
    caches the 10-dimension contribution and ``assessment_id`` links the synthetic
    check-in assessment so trends/insights see it on one timeline.
    """

    __tablename__ = "mood_entries"

    id: Mapped[str] = mapped_column(String(32), primary_key=True, default=new_id)
    user_id: Mapped[str] = mapped_column(
        ForeignKey("users.id", ondelete="CASCADE"), index=True
    )
    level: Mapped[int] = mapped_column(Integer)           # 1..5
    factors: Mapped[list] = mapped_column(JSON, default=list)
    note: Mapped[str] = mapped_column(Text, default="")
    dimension_deltas: Mapped[dict] = mapped_column(JSON, default=dict)
    assessment_id: Mapped[str | None] = mapped_column(String(32), nullable=True)
    created_at: Mapped[datetime] = mapped_column(DateTime, default=utcnow, index=True)
