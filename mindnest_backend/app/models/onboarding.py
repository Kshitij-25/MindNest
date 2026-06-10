from __future__ import annotations

from datetime import datetime

from sqlalchemy import JSON, DateTime, ForeignKey, Integer, String
from sqlalchemy.orm import Mapped, mapped_column

from app.core.utils import new_id, utcnow
from app.database import Base


class OnboardingResponse(Base):
    """The five-field onboarding intake.

    Kept as a thin record AND used to seed an initial emotional baseline:
    ``onboarding_service`` maps these fields into a dimension contribution,
    runs the scoring engine and persists a synthetic completed assessment +
    mood profile (``seeded_assessment_id``).
    """

    __tablename__ = "onboarding_responses"

    id: Mapped[str] = mapped_column(String(32), primary_key=True, default=new_id)
    user_id: Mapped[str] = mapped_column(
        ForeignKey("users.id", ondelete="CASCADE"), unique=True, index=True
    )
    mood: Mapped[int] = mapped_column(Integer)          # 1..5
    stress: Mapped[int] = mapped_column(Integer)        # 0..10
    sleep: Mapped[int] = mapped_column(Integer)         # 1..5
    anxiety: Mapped[int | None] = mapped_column(Integer, nullable=True)  # 0..3
    goals: Mapped[list] = mapped_column(JSON, default=list)
    focus_areas: Mapped[list] = mapped_column(JSON, default=list)
    seeded_assessment_id: Mapped[str | None] = mapped_column(
        String(32), nullable=True
    )
    created_at: Mapped[datetime] = mapped_column(DateTime, default=utcnow)
