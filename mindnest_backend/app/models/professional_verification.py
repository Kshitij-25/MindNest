"""Credential documents submitted by a professional for manual review (MVP 2)."""
from __future__ import annotations

from datetime import datetime

from sqlalchemy import DateTime, ForeignKey, String, Text
from sqlalchemy.orm import Mapped, mapped_column

from app.core.utils import new_id, utcnow
from app.database import Base
from app.models.professional import VerificationStatus  # re-exported for callers

__all__ = ["ProfessionalVerification", "VerificationStatus"]


class ProfessionalVerification(Base):
    __tablename__ = "professional_verifications"

    id: Mapped[str] = mapped_column(String(32), primary_key=True, default=new_id)
    professional_id: Mapped[str] = mapped_column(
        ForeignKey("professionals.id", ondelete="CASCADE"), index=True
    )
    # license | certification | identity
    document_type: Mapped[str] = mapped_column(String(40))
    document_url: Mapped[str] = mapped_column(String(512))
    note: Mapped[str] = mapped_column(Text, default="")
    status: Mapped[str] = mapped_column(
        String(16), default=VerificationStatus.PENDING, index=True
    )
    review_note: Mapped[str] = mapped_column(Text, default="")
    reviewed_at: Mapped[datetime | None] = mapped_column(DateTime, nullable=True)
    created_at: Mapped[datetime] = mapped_column(DateTime, default=utcnow)
