"""The professional actor (MVP 2).

A professional authenticates separately from a :class:`~app.models.user.User`
(its own table + its own login flow). Tokens carry an ``actor="professional"``
claim so the two identity spaces never cross (see ``core/security.py`` and
``api/deps.py``). The profile fields double as the public marketplace card.
"""
from __future__ import annotations

from datetime import datetime

from sqlalchemy import (
    JSON,
    Boolean,
    DateTime,
    Float,
    ForeignKey,
    Integer,
    String,
    Text,
)
from sqlalchemy.orm import Mapped, mapped_column

from app.core.utils import new_id, utcnow
from app.database import Base


class VerificationStatus:
    """Lifecycle of a professional's credential verification."""

    PENDING = "pending"
    APPROVED = "approved"
    REJECTED = "rejected"


class Professional(Base):
    __tablename__ = "professionals"

    id: Mapped[str] = mapped_column(String(32), primary_key=True, default=new_id)
    email: Mapped[str] = mapped_column(String(255), unique=True, index=True)
    hashed_password: Mapped[str] = mapped_column(String(255))

    name: Mapped[str] = mapped_column(String(120))
    photo: Mapped[str | None] = mapped_column(String(512), nullable=True)
    title: Mapped[str | None] = mapped_column(String(160), nullable=True)
    # slug keys from app.core.specializations
    specializations: Mapped[list] = mapped_column(JSON, default=list)
    languages: Mapped[list] = mapped_column(JSON, default=list)
    experience_years: Mapped[int] = mapped_column(Integer, default=0)
    bio: Mapped[str] = mapped_column(Text, default="")
    education: Mapped[list] = mapped_column(JSON, default=list)
    certifications: Mapped[list] = mapped_column(JSON, default=list)

    verification_status: Mapped[str] = mapped_column(
        String(16), default=VerificationStatus.PENDING, index=True
    )
    rating: Mapped[float] = mapped_column(Float, default=0.0)        # 0..5 avg
    review_count: Mapped[int] = mapped_column(Integer, default=0)
    session_price: Mapped[float] = mapped_column(Float, default=0.0)
    currency: Mapped[str] = mapped_column(String(8), default="USD")
    timezone: Mapped[str] = mapped_column(String(64), default="UTC")

    is_active: Mapped[bool] = mapped_column(Boolean, default=True)
    created_at: Mapped[datetime] = mapped_column(DateTime, default=utcnow)


class ProfessionalSession(Base):
    """A professional login / device session (backs refresh-token rotation).

    Mirrors :class:`~app.models.session.Session` but for the professional
    identity space, so the two never share refresh sessions.
    """

    __tablename__ = "professional_sessions"

    id: Mapped[str] = mapped_column(String(32), primary_key=True, default=new_id)
    professional_id: Mapped[str] = mapped_column(
        ForeignKey("professionals.id", ondelete="CASCADE"), index=True
    )
    device: Mapped[str | None] = mapped_column(String(255), nullable=True)
    created_at: Mapped[datetime] = mapped_column(DateTime, default=utcnow)
    last_seen_at: Mapped[datetime] = mapped_column(DateTime, default=utcnow)
    data: Mapped[dict] = mapped_column(JSON, default=dict)
