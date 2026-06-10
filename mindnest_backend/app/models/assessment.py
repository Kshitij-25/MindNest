from __future__ import annotations

from datetime import datetime

from sqlalchemy import JSON, DateTime, ForeignKey, Integer, String
from sqlalchemy.orm import Mapped, mapped_column, relationship

from app.core.utils import new_id, utcnow
from app.database import Base


class AssessmentStatus:
    IN_PROGRESS = "in_progress"
    COMPLETED = "completed"
    ABANDONED = "abandoned"


class Assessment(Base):
    __tablename__ = "assessments"

    id: Mapped[str] = mapped_column(String(32), primary_key=True, default=new_id)
    user_id: Mapped[str] = mapped_column(
        ForeignKey("users.id", ondelete="CASCADE"), index=True
    )
    status: Mapped[str] = mapped_column(
        String(20), default=AssessmentStatus.IN_PROGRESS, index=True
    )
    stage: Mapped[str] = mapped_column(String(20), default="baseline")
    question_count: Mapped[int] = mapped_column(Integer, default=0)
    started_at: Mapped[datetime] = mapped_column(DateTime, default=utcnow)
    completed_at: Mapped[datetime | None] = mapped_column(DateTime, nullable=True)
    # Free-form bag for client context (device, app version, locale, ...).
    meta: Mapped[dict] = mapped_column(JSON, default=dict)

    user: Mapped["User"] = relationship(back_populates="assessments")  # noqa: F821
    answers: Mapped[list["Answer"]] = relationship(  # noqa: F821
        back_populates="assessment",
        cascade="all, delete-orphan",
        order_by="Answer.order_index",
    )
    mood_profile: Mapped["MoodProfile | None"] = relationship(  # noqa: F821
        back_populates="assessment",
        cascade="all, delete-orphan",
        uselist=False,
    )
