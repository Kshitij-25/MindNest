"""Camel-cased notification schemas."""
from __future__ import annotations

from datetime import datetime

from app.schemas.common import CamelModel


class NotificationOut(CamelModel):
    id: str
    type: str
    title: str
    body: str = ""
    unread: bool
    ref_id: str | None = None
    relative_time: str
    created_at: datetime


class MarkAllReadOut(CamelModel):
    ok: bool = True
