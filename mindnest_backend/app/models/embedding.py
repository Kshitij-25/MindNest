from __future__ import annotations

from datetime import datetime

from sqlalchemy import JSON, DateTime, ForeignKey, Integer, String, Text
from sqlalchemy.orm import Mapped, mapped_column

from app.core.utils import new_id, utcnow
from app.database import Base


class Embedding(Base):
    """Vector memory for free-text / journal entries.

    Vectors are stored as a JSON list of floats — perfectly adequate for
    the SQLite MVP and a few thousand entries. The cosine-similarity search
    lives in ``app/services/mood_service.py`` (pure Python, no numpy needed).
    For large scale, swap this table for pgvector with no API changes.
    """

    __tablename__ = "embeddings"

    id: Mapped[str] = mapped_column(String(32), primary_key=True, default=new_id)
    user_id: Mapped[str] = mapped_column(
        ForeignKey("users.id", ondelete="CASCADE"), index=True
    )
    assessment_id: Mapped[str | None] = mapped_column(
        ForeignKey("assessments.id", ondelete="CASCADE"), nullable=True, index=True
    )
    # assessment | journal | checkin | insight
    source: Mapped[str] = mapped_column(String(32), default="journal")
    journal_id: Mapped[str | None] = mapped_column(String(32), nullable=True, index=True)
    mood_entry_id: Mapped[str | None] = mapped_column(String(32), nullable=True)
    text: Mapped[str] = mapped_column(Text, default="")
    model: Mapped[str] = mapped_column(String(128), default="")
    dim: Mapped[int] = mapped_column(Integer, default=0)
    vector: Mapped[list] = mapped_column(JSON, default=list)
    created_at: Mapped[datetime] = mapped_column(DateTime, default=utcnow, index=True)
