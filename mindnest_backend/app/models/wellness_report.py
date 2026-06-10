from __future__ import annotations

from datetime import datetime

from sqlalchemy import JSON, DateTime, ForeignKey, String, Text, UniqueConstraint
from sqlalchemy.orm import Mapped, mapped_column

from app.core.utils import new_id, utcnow
from app.database import Base


class WellnessReport(Base):
    """A cached weekly wellness report (one per user per ISO week)."""

    __tablename__ = "wellness_reports"
    __table_args__ = (
        UniqueConstraint("user_id", "period_key", name="uq_report_period"),
    )

    id: Mapped[str] = mapped_column(String(32), primary_key=True, default=new_id)
    user_id: Mapped[str] = mapped_column(
        ForeignKey("users.id", ondelete="CASCADE"), index=True
    )
    period_key: Mapped[str] = mapped_column(String(16), index=True)  # 2026-W23
    payload: Mapped[dict] = mapped_column(JSON, default=dict)
    narrative: Mapped[str] = mapped_column(Text, default="")
    generated_at: Mapped[datetime] = mapped_column(DateTime, default=utcnow, index=True)
