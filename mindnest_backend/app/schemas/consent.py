"""Data-sharing consent schemas (camelCase)."""
from __future__ import annotations

from datetime import datetime

from pydantic import Field

from app.schemas.common import CamelModel


class ConsentGrant(CamelModel):
    professional_id: str
    scopes: list[str] = Field(
        description=(
            "emotional_profile | insights | assessment_history | "
            "journal_summaries | wellness_reports"
        )
    )


class ConsentRevoke(CamelModel):
    professional_id: str
    scope: str


class ConsentOut(CamelModel):
    id: str
    professional_id: str
    scope: str
    granted: bool
    granted_at: datetime | None = None
    revoked_at: datetime | None = None
    created_at: datetime
