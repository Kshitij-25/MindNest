from __future__ import annotations

from datetime import datetime

from sqlalchemy import JSON, DateTime, ForeignKey, Integer, String
from sqlalchemy.orm import Mapped, mapped_column, relationship

from app.core.utils import new_id, utcnow
from app.database import Base


class Answer(Base):
    __tablename__ = "answers"

    id: Mapped[str] = mapped_column(String(32), primary_key=True, default=new_id)
    assessment_id: Mapped[str] = mapped_column(
        ForeignKey("assessments.id", ondelete="CASCADE"), index=True
    )
    question_id: Mapped[str] = mapped_column(ForeignKey("questions.id"), index=True)
    order_index: Mapped[int] = mapped_column(Integer, default=0)

    # Raw answer as sent by the client. One of:
    #   {"option_id": "anxious"}      (multiple_choice / emoji)
    #   {"value": 7}                  (slider)
    #   {"text": "..."}               (free_text / journal)
    #   {"skipped": true}             (any type)
    raw_value: Mapped[dict] = mapped_column(JSON, default=dict)

    # Per-answer analysis: dimension contributions + NLP results, so we
    # never have to re-run the AI pipeline to explain a past answer.
    derived: Mapped[dict] = mapped_column(JSON, default=dict)

    created_at: Mapped[datetime] = mapped_column(DateTime, default=utcnow)

    assessment: Mapped["Assessment"] = relationship(  # noqa: F821
        back_populates="answers"
    )
