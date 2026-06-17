"""User-controlled data-sharing consent (MVP 2).

A professional can only ever see a slice of a user's AI wellness data when the
user has *explicitly* granted consent for that slice. Consent is never implied
or auto-granted — each (user, professional, scope) is its own record.
"""
from __future__ import annotations

from datetime import datetime

from sqlalchemy import (
    Boolean,
    DateTime,
    ForeignKey,
    String,
    UniqueConstraint,
)
from sqlalchemy.orm import Mapped, mapped_column

from app.core.utils import new_id, utcnow
from app.database import Base


class ConsentScope:
    EMOTIONAL_PROFILE = "emotional_profile"
    INSIGHTS = "insights"
    ASSESSMENT_HISTORY = "assessment_history"
    JOURNAL_SUMMARIES = "journal_summaries"
    WELLNESS_REPORTS = "wellness_reports"


CONSENT_SCOPES: list[str] = [
    ConsentScope.EMOTIONAL_PROFILE,
    ConsentScope.INSIGHTS,
    ConsentScope.ASSESSMENT_HISTORY,
    ConsentScope.JOURNAL_SUMMARIES,
    ConsentScope.WELLNESS_REPORTS,
]


class ConsentRecord(Base):
    __tablename__ = "consent_records"
    __table_args__ = (
        UniqueConstraint(
            "user_id", "professional_id", "scope", name="uq_consent_triple"
        ),
    )

    id: Mapped[str] = mapped_column(String(32), primary_key=True, default=new_id)
    user_id: Mapped[str] = mapped_column(
        ForeignKey("users.id", ondelete="CASCADE"), index=True
    )
    professional_id: Mapped[str] = mapped_column(
        ForeignKey("professionals.id", ondelete="CASCADE"), index=True
    )
    scope: Mapped[str] = mapped_column(String(40), index=True)
    granted: Mapped[bool] = mapped_column(Boolean, default=True)
    granted_at: Mapped[datetime | None] = mapped_column(DateTime, nullable=True)
    revoked_at: Mapped[datetime | None] = mapped_column(DateTime, nullable=True)
    created_at: Mapped[datetime] = mapped_column(DateTime, default=utcnow)
