"""Mood check-in read models (history, calendar, trends, insights).

All derived from ``MoodEntry`` rows (the simple surface) plus the shared
``insights_service`` (the engine substrate). Shapes are the camelCase the
Flutter mood screens render directly.
"""
from __future__ import annotations

import calendar as _calendar
from datetime import date, datetime, timedelta

from sqlalchemy import select

from app.core.time_format import clock_label, day_label, day_levels, relative_time
from app.core.utils import utcnow
from app.models import MoodEntry, Streak, User
from app.services import insights_service


async def _entries_since(db, user: User, cutoff: datetime) -> list[MoodEntry]:
    res = await db.execute(
        select(MoodEntry)
        .where(MoodEntry.user_id == user.id, MoodEntry.created_at >= cutoff)
        .order_by(MoodEntry.created_at)
    )
    return list(res.scalars().all())


def _average(entries: list[MoodEntry]) -> float:
    if not entries:
        return 0.0
    return round(sum(e.level for e in entries) / len(entries), 1)


def _trend_label(entries: list[MoodEntry]) -> str:
    """Compare the first vs second half of the window's actual levels."""
    if len(entries) < 2:
        return "Steady"
    mid = len(entries) // 2
    first = entries[:mid] or entries[:1]
    second = entries[mid:]
    a = sum(e.level for e in first) / len(first)
    b = sum(e.level for e in second) / len(second)
    diff = b - a
    if diff >= 0.4:
        return "Improving"
    if diff <= -0.4:
        return "Declining"
    return "Steady"


async def _streak(db, user: User) -> Streak | None:
    res = await db.execute(select(Streak).where(Streak.user_id == user.id))
    return res.scalar_one_or_none()


async def history(db, user: User, *, days: int = 28, recent: int = 8) -> dict:
    cutoff = utcnow() - timedelta(days=days)
    entries = await _entries_since(db, user, cutoff)
    pairs = [(e.created_at, e.level) for e in entries]
    recents = sorted(entries, key=lambda e: e.created_at, reverse=True)[:recent]
    return {
        "month_levels": day_levels(pairs, days=days),
        "average": _average(entries),
        "trend_label": _trend_label(entries),
        "recent": [
            {
                "id": e.id,
                "level": e.level,
                "factors": e.factors or [],
                "note": e.note or "",
                "day_label": day_label(e.created_at),
                "clock_label": clock_label(e.created_at),
                "relative_time": relative_time(e.created_at),
                "created_at": e.created_at,
            }
            for e in recents
        ],
    }


async def calendar(db, user: User, *, year: int | None = None, month: int | None = None) -> dict:
    today = utcnow().date()
    year = year or today.year
    month = month or today.month
    start = date(year, month, 1)
    days_in_month = _calendar.monthrange(year, month)[1]
    end = date(year, month, days_in_month)

    res = await db.execute(
        select(MoodEntry.created_at, MoodEntry.level).where(
            MoodEntry.user_id == user.id,
            MoodEntry.created_at >= datetime(start.year, start.month, start.day),
            MoodEntry.created_at < datetime(year, month, days_in_month) + timedelta(days=1),
        )
    )
    by_day: dict[int, list[int]] = {}
    for created_at, level in res.all():
        by_day.setdefault(created_at.day, []).append(level)

    days = []
    for d in range(1, days_in_month + 1):
        vals = by_day.get(d)
        days.append({
            "date": f"{year:04d}-{month:02d}-{d:02d}",
            "day": d,
            "level": round(sum(vals) / len(vals)) if vals else None,
            "has_entry": bool(vals),
        })
    return {"year": year, "month": month, "days": days}


async def trends(db, user: User, *, days: int = 30) -> dict:
    """camelCase wrapper over the shared trends engine."""
    return await insights_service.trends(db, user, days=days)


def _distribution(entries: list[MoodEntry]) -> list[dict]:
    counts = {lvl: 0 for lvl in range(1, 6)}
    for e in entries:
        if 1 <= e.level <= 5:
            counts[e.level] += 1
    return [{"level": lvl, "count": counts[lvl]} for lvl in range(1, 6)]


async def insights(db, user: User, *, days: int = 7) -> dict:
    cutoff = utcnow() - timedelta(days=days)
    week_entries = await _entries_since(db, user, cutoff)
    month_entries = await _entries_since(db, user, utcnow() - timedelta(days=28))

    week_pairs = [(e.created_at, e.level) for e in week_entries]
    month_pairs = [(e.created_at, e.level) for e in month_entries]

    streak = await _streak(db, user)
    engine_insights = await insights_service.insights(db, user, days=max(days, 7))

    cards = []
    headline = engine_insights.get("headline", "")
    messages = engine_insights.get("insights", [])
    for i, msg in enumerate(messages[:3]):
        cards.append({
            "title": headline if i == 0 else "Pattern",
            "body": msg,
            "topic_index": i % 5,
            "color_key": f"topic{i % 5}",
        })

    return {
        "streak_days": streak.current if streak else 0,
        "streak_goal": streak.goal if streak else (getattr(user, "streak_goal", 7) or 7),
        "average": _average(week_entries),
        "trend_label": _trend_label(week_entries),
        "week": day_levels(week_pairs, days=7),
        "month": day_levels(month_pairs, days=28),
        "distribution": _distribution(month_entries),
        "cards": cards,
    }
