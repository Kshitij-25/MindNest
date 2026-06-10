"""Camel-cased AI coach schemas."""
from __future__ import annotations

from datetime import datetime
from typing import Any

from pydantic import Field

from app.schemas.common import CamelModel


class CoachChatRequest(CamelModel):
    message: str = Field(min_length=1, max_length=4000)
    conversation_id: str | None = None


class CoachChatOut(CamelModel):
    conversation_id: str
    reply: str
    model: str
    context: dict[str, Any] = Field(default_factory=dict)
    created_at: datetime


class CoachMessageOut(CamelModel):
    id: str
    conversation_id: str
    role: str
    content: str
    created_at: datetime


class CoachConversationOut(CamelModel):
    id: str
    title: str
    created_at: datetime
    updated_at: datetime
