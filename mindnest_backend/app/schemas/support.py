"""AI → human support handoff (referral) schemas (camelCase)."""
from __future__ import annotations

from pydantic import Field

from app.schemas.common import CamelModel
from app.schemas.marketplace import MatchOut

_DISCLAIMER = (
    "MindNest is not a medical service and does not diagnose. This is a "
    "suggestion to consider human support, not a clinical assessment."
)


class ReferralOut(CamelModel):
    should_suggest: bool
    severity: str = "none"  # none | low | moderate | high
    reasons: list[str] = Field(default_factory=list)
    recommended_specializations: list[str] = Field(default_factory=list)
    message: str = ""
    professionals: list[MatchOut] = Field(default_factory=list)
    disclaimer: str = _DISCLAIMER
