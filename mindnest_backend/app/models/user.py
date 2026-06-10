from __future__ import annotations

from datetime import datetime

from sqlalchemy import JSON, Boolean, DateTime, Integer, String, Text
from sqlalchemy.orm import Mapped, mapped_column, relationship

from app.core.utils import new_id, utcnow
from app.database import Base


class User(Base):
    __tablename__ = "users"

    id: Mapped[str] = mapped_column(String(32), primary_key=True, default=new_id)
    email: Mapped[str] = mapped_column(String(255), unique=True, index=True)
    hashed_password: Mapped[str] = mapped_column(String(255))
    display_name: Mapped[str | None] = mapped_column(String(120), nullable=True)
    avatar_url: Mapped[str | None] = mapped_column(String(512), nullable=True)
    about: Mapped[str | None] = mapped_column(Text, nullable=True)
    phone: Mapped[str | None] = mapped_column(String(40), nullable=True)
    is_active: Mapped[bool] = mapped_column(Boolean, default=True)
    onboarded: Mapped[bool] = mapped_column(Boolean, default=False)
    streak_goal: Mapped[int] = mapped_column(Integer, default=7)
    # notification prefs, theme, and a nested "feature_flags" map
    settings: Mapped[dict] = mapped_column(JSON, default=dict)
    created_at: Mapped[datetime] = mapped_column(DateTime, default=utcnow)

    assessments: Mapped[list["Assessment"]] = relationship(  # noqa: F821
        back_populates="user", cascade="all, delete-orphan"
    )
    mood_profiles: Mapped[list["MoodProfile"]] = relationship(  # noqa: F821
        back_populates="user", cascade="all, delete-orphan"
    )
