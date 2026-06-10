from __future__ import annotations

from sqlalchemy import Integer, String
from sqlalchemy.orm import Mapped, mapped_column

from app.database import Base


class Topic(Base):
    """Reference vocabulary for life-topics + their UI colour mapping.

    ``topic_index`` / ``color_key`` mirror the Flutter theme so feed/journal/
    insight cards can return the colour the client expects without duplicating
    the mapping. Seeded at startup.
    """

    __tablename__ = "topics"

    id: Mapped[str] = mapped_column(String(32), primary_key=True)  # slug
    name: Mapped[str] = mapped_column(String(64), index=True)
    topic_index: Mapped[int] = mapped_column(Integer, default=0)
    color_key: Mapped[str] = mapped_column(String(16), default="topic0")
