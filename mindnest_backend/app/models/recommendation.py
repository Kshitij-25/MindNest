from __future__ import annotations

from datetime import datetime

from sqlalchemy import JSON, DateTime, Float, ForeignKey, String, Text
from sqlalchemy.orm import Mapped, mapped_column

from app.core.utils import new_id, utcnow
from app.database import Base


class RecommendationStatus:
    ACTIVE = "active"
    ACCEPTED = "accepted"
    DISMISSED = "dismissed"
    COMPLETED = "completed"


class Recommendation(Base):
    """A personalised wellness nudge derived from the user's emotional state."""

    __tablename__ = "recommendations"

    id: Mapped[str] = mapped_column(String(32), primary_key=True, default=new_id)
    user_id: Mapped[str] = mapped_column(
        ForeignKey("users.id", ondelete="CASCADE"), index=True
    )
    # journal_prompt|reflection|breathing|sleep|habit|mindfulness
    kind: Mapped[str] = mapped_column(String(24), index=True)
    title: Mapped[str] = mapped_column(String(200))
    body: Mapped[str] = mapped_column(Text, default="")
    score: Mapped[float] = mapped_column(Float, default=0.0)
    reason: Mapped[str] = mapped_column(Text, default="")
    source: Mapped[dict] = mapped_column(JSON, default=dict)
    status: Mapped[str] = mapped_column(
        String(16), default=RecommendationStatus.ACTIVE, index=True
    )
    created_at: Mapped[datetime] = mapped_column(DateTime, default=utcnow, index=True)


class RecommendationFeedback(Base):
    """User feedback on a recommendation — closes the learning loop."""

    __tablename__ = "recommendation_feedback"

    id: Mapped[str] = mapped_column(String(32), primary_key=True, default=new_id)
    recommendation_id: Mapped[str] = mapped_column(
        ForeignKey("recommendations.id", ondelete="CASCADE"), index=True
    )
    user_id: Mapped[str] = mapped_column(
        ForeignKey("users.id", ondelete="CASCADE"), index=True
    )
    # accepted|dismissed|completed|helpful|not_helpful
    action: Mapped[str] = mapped_column(String(20))
    kind: Mapped[str] = mapped_column(String(24), default="", index=True)  # denormalised
    created_at: Mapped[datetime] = mapped_column(DateTime, default=utcnow, index=True)
