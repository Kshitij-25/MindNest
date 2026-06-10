from __future__ import annotations

from datetime import datetime

from sqlalchemy import DateTime, ForeignKey, String, Text
from sqlalchemy.orm import Mapped, mapped_column

from app.core.utils import new_id, utcnow
from app.database import Base


class Memory(Base):
    """Higher-level emotional-memory index over the vector store.

    One row per remembered item (a journal entry, an assessment, an insight),
    linking to its ``Embedding`` for semantic retrieval and carrying a short
    human-readable ``summary``/``text`` for snippeting in coach + search.
    """

    __tablename__ = "memories"

    id: Mapped[str] = mapped_column(String(32), primary_key=True, default=new_id)
    user_id: Mapped[str] = mapped_column(
        ForeignKey("users.id", ondelete="CASCADE"), index=True
    )
    kind: Mapped[str] = mapped_column(String(20), index=True)  # journal|assessment|insight
    ref_id: Mapped[str | None] = mapped_column(String(32), nullable=True, index=True)
    text: Mapped[str] = mapped_column(Text, default="")
    summary: Mapped[str] = mapped_column(Text, default="")
    embedding_id: Mapped[str | None] = mapped_column(
        ForeignKey("embeddings.id", ondelete="SET NULL"), nullable=True
    )
    created_at: Mapped[datetime] = mapped_column(DateTime, default=utcnow, index=True)
