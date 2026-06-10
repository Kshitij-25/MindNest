from __future__ import annotations

from sqlalchemy import JSON, Boolean, String
from sqlalchemy.orm import Mapped, mapped_column

from app.database import Base


class Question(Base):
    """The question bank.

    Seeded at startup from ``app/data/questions.json``. The adaptive
    engine keeps an in-memory copy for fast selection, while this table
    gives answers a stable foreign-key target and persists the bank.
    """

    __tablename__ = "questions"

    id: Mapped[str] = mapped_column(String(64), primary_key=True)
    text: Mapped[str] = mapped_column(String(512))
    # multiple_choice | slider | free_text | emoji | journal
    type: Mapped[str] = mapped_column(String(32), index=True)
    # primary emotional dimension this item probes (or "general")
    dimension: Mapped[str] = mapped_column(String(32), index=True)
    stage: Mapped[str] = mapped_column(String(20), default="baseline", index=True)
    is_active: Mapped[bool] = mapped_column(Boolean, default=True)
    # options / slider config / scoring rules / branching follow-ups
    payload: Mapped[dict] = mapped_column(JSON, default=dict)
