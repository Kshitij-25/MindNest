"""Display-string helpers so services emit exactly what the UI renders.

The Flutter app shows pre-formatted relative times ("5m", "2h", "Yesterday"),
day labels ("Today"/"Wed"), calendar dates ("31 May") and clock labels
("9:24 AM"); it also charts fixed-length int arrays (7-day week, 28-day month).
All of that is derived here from naive-UTC timestamps so the client never has
to reconstruct it.
"""
from __future__ import annotations

from datetime import date, datetime, timedelta

from app.core.utils import utcnow

_WEEKDAYS = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
_MONTHS = ["Jan", "Feb", "Mar", "Apr", "May", "Jun",
           "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]


def relative_time(dt: datetime, *, now: datetime | None = None) -> str:
    """Compact relative label: "now", "5m", "2h", "Yesterday", "Mon", "31 May"."""
    now = now or utcnow()
    delta = now - dt
    secs = delta.total_seconds()
    if secs < 60:
        return "now"
    if secs < 3600:
        return f"{int(secs // 60)}m"
    if secs < 86400 and now.date() == dt.date():
        return f"{int(secs // 3600)}h"
    days = (now.date() - dt.date()).days
    if days == 1:
        return "Yesterday"
    if 2 <= days < 7:
        return _WEEKDAYS[dt.weekday()]
    return date_label(dt)


def day_label(dt: datetime, *, now: datetime | None = None) -> str:
    """Relative day: "Today" / "Yesterday" / weekday / "31 May"."""
    now = now or utcnow()
    days = (now.date() - dt.date()).days
    if days <= 0:
        return "Today"
    if days == 1:
        return "Yesterday"
    if days < 7:
        return _WEEKDAYS[dt.weekday()]
    return date_label(dt)


def date_label(dt: datetime | date) -> str:
    """Calendar date like "31 May"."""
    return f"{dt.day} {_MONTHS[dt.month - 1]}"


def clock_label(dt: datetime) -> str:
    """12-hour clock like "9:24 AM" (no leading zero on the hour)."""
    hour = dt.hour % 12 or 12
    ampm = "AM" if dt.hour < 12 else "PM"
    return f"{hour}:{dt.minute:02d} {ampm}"


def iso_week_key(dt: datetime | date) -> str:
    """ISO week key like "2026-W23" (used for weekly report period keys)."""
    y, w, _ = dt.isocalendar()
    return f"{y}-W{w:02d}"


def day_levels(
    pairs: list[tuple[datetime, int]],
    *,
    days: int,
    now: datetime | None = None,
    default: int = 3,
    carry_forward: bool = True,
) -> list[int]:
    """Bucket ``(timestamp, level)`` pairs into a fixed-length per-day array.

    Returns ``days`` ints ending today. Multiple entries on a day average
    (rounded). Empty days carry the last known level forward (or ``default``).
    """
    now = now or utcnow()
    today = now.date()
    buckets: dict[date, list[int]] = {}
    for dt, level in pairs:
        buckets.setdefault(dt.date(), []).append(level)

    out: list[int] = []
    last = default
    for i in range(days - 1, -1, -1):
        d = today - timedelta(days=i)
        vals = buckets.get(d)
        if vals:
            last = round(sum(vals) / len(vals))
            out.append(last)
        else:
            out.append(last if carry_forward else default)
    return out
