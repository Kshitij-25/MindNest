"""Camel-cased recommendation schemas."""
from __future__ import annotations

from datetime import datetime
from typing import Annotated, Any

from pydantic import StringConstraints

from app.schemas.common import CamelModel

# accepted | dismissed | completed | helpful | not_helpful
FeedbackAction = Annotated[
    str,
    StringConstraints(strip_whitespace=True, to_lower=True),
]


class RecommendationOut(CamelModel):
    id: str
    kind: str
    title: str
    body: str
    score: float
    reason: str
    status: str
    source: dict[str, Any] = {}
    created_at: datetime


class FeedbackRequest(CamelModel):
    action: FeedbackAction


class FeedbackOut(CamelModel):
    id: str
    recommendation_id: str
    action: str
    status: str
