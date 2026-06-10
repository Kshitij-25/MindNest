from __future__ import annotations

from datetime import datetime

from sqlalchemy import JSON, DateTime, ForeignKey, String
from sqlalchemy.orm import Mapped, mapped_column

from app.core.utils import new_id, utcnow
from app.database import Base


class Insight(Base):
    """Cached insight payloads keyed by scope + period.

    Cheap to recompute from EmotionalHistory, but memoised so dashboard/insights
    reads are snappy and so repeated requests in a period are stable.
    """

    __tablename__ = "insights"

    id: Mapped[str] = mapped_column(String(32), primary_key=True, default=new_id)
    user_id: Mapped[str] = mapped_column(
        ForeignKey("users.id", ondelete="CASCADE"), index=True
    )
    scope: Mapped[str] = mapped_column(String(16), index=True)   # daily|weekly|monthly
    period_key: Mapped[str] = mapped_column(String(16), index=True)  # e.g. 2026-W23
    payload: Mapped[dict] = mapped_column(JSON, default=dict)
    generated_at: Mapped[datetime] = mapped_column(DateTime, default=utcnow)
