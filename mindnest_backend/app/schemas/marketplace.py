"""Marketplace schemas — ranked matches built on top of ProfessionalOut."""
from __future__ import annotations

from pydantic import Field

from app.schemas.common import CamelModel
from app.schemas.professional import ProfessionalOut


class MatchOut(CamelModel):
    """A professional plus why the matching engine surfaced them."""

    professional: ProfessionalOut
    score: float
    reasons: list[str] = Field(default_factory=list)
