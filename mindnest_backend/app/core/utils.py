"""Small shared helpers."""
from __future__ import annotations

import uuid
from datetime import datetime, timezone


def utcnow() -> datetime:
    """Timezone-naive UTC timestamp.

    We deliberately store *naive UTC* everywhere so comparisons across
    SQLite reads/writes never mix aware and naive datetimes.
    """
    return datetime.now(timezone.utc).replace(tzinfo=None)


def new_id() -> str:
    """A short, URL-safe unique id."""
    return uuid.uuid4().hex
