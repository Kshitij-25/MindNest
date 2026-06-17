"""Messaging schemas (camelCase)."""
from __future__ import annotations

from datetime import datetime

from pydantic import Field

from app.schemas.common import CamelModel


class ConversationStart(CamelModel):
    professional_id: str


class ConversationOut(CamelModel):
    id: str
    user_id: str
    professional_id: str
    created_at: datetime
    last_message_at: datetime
    unread_count: int = 0
    last_message: str | None = None


class MessageCreate(CamelModel):
    body: str = Field(min_length=1)
    attachments: list[dict] = Field(default_factory=list)


class MessageOut(CamelModel):
    id: str
    conversation_id: str
    sender_type: str
    sender_id: str
    body: str
    attachments: list[dict] = Field(default_factory=list)
    read: bool = False
    created_at: datetime
