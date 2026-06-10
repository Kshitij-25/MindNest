"""Pagination helpers: offset params + opaque keyset cursors.

Most wellness lists are short and return bare arrays. The few unbounded
surfaces (e.g. coach history, notifications) can use keyset cursors encoded
here as opaque base64 of ``(created_at_iso, id)`` — stable under inserts and
free of offset drift. Pure-Python, no dependencies.
"""
from __future__ import annotations

import base64
import binascii
from datetime import datetime


def encode_cursor(created_at: datetime, item_id: str) -> str:
    raw = f"{created_at.isoformat()}|{item_id}".encode("utf-8")
    return base64.urlsafe_b64encode(raw).decode("ascii")


def decode_cursor(cursor: str | None) -> tuple[datetime, str] | None:
    """Return ``(created_at, id)`` or ``None`` if absent/malformed."""
    if not cursor:
        return None
    try:
        raw = base64.urlsafe_b64decode(cursor.encode("ascii")).decode("utf-8")
        ts, item_id = raw.split("|", 1)
        return datetime.fromisoformat(ts), item_id
    except (ValueError, binascii.Error, UnicodeDecodeError):
        return None


def clamp_limit(limit: int | None, default: int = 20, maximum: int = 100) -> int:
    if not limit or limit < 1:
        return default
    return min(limit, maximum)
