"""Computes a single 0–100 wellness score from the latest emotional profile.

Each dimension is converted to a "health" value (positive dimensions as-is,
negative dimensions inverted), then a weighted blend across the headline
signals yields the score. The spark is a 7-day proxy built from recent mood
check-ins; the weekly change is the slope across that window.
"""
from __future__ import annotations

from datetime import timedelta

from sqlalchemy import select

from app.core.dimensions import (
    ANXIETY,
    BASELINES,
    BURNOUT,
    FATIGUE,
    HAPPINESS,
    INSTABILITY,
    MOTIVATION,
    POSITIVE_DIMENSIONS,
    STRESS,
)
from app.core.time_format import day_levels
from app.core.utils import utcnow
from app.models import MoodEntry, MoodProfile, User

# (label, dimension, weight, icon) — mirrors the app's signal row.
_SIGNALS = [
    ("Mood", HAPPINESS, "High", "smile"),
    ("Stress", STRESS, "High", "pulse"),
    ("Anxiety", ANXIETY, "Med", "wind"),
    ("Motivation", MOTIVATION, "Med", "zap"),
    ("Burnout", BURNOUT, "High", "flame"),
    ("Energy", FATIGUE, "Med", "sleep"),
    ("Stability", INSTABILITY, "Low", "repeat"),
]
_WEIGHTS = {"High": 1.4, "Med": 1.0, "Low": 0.6}


def _health(dimension: str, score: float) -> float:
    return score if dimension in POSITIVE_DIMENSIONS else 100.0 - score


def _band(score: int) -> str:
    if score >= 75:
        return "Thriving"
    if score >= 60:
        return "Balanced"
    if score >= 45:
        return "Managing"
    return "Struggling"


async def _latest_profile(db, user: User) -> MoodProfile | None:
    res = await db.execute(
        select(MoodProfile)
        .where(MoodProfile.user_id == user.id)
        .order_by(MoodProfile.created_at.desc())
        .limit(1)
    )
    return res.scalar_one_or_none()


async def _spark(db, user: User) -> list[int]:
    cutoff = utcnow() - timedelta(days=8)
    res = await db.execute(
        select(MoodEntry.created_at, MoodEntry.level)
        .where(MoodEntry.user_id == user.id, MoodEntry.created_at >= cutoff)
        .order_by(MoodEntry.created_at)
    )
    levels = day_levels([(row[0], row[1]) for row in res.all()], days=7)
    # 1..5 mood level → 0..100 proxy; carry the last known value over gaps.
    out: list[int] = []
    last = 60
    for lvl in levels:
        if lvl and lvl > 0:
            last = int(max(0, min(100, lvl * 20)))
        out.append(last)
    return out


async def wellness_score(db, user: User) -> dict:
    profile = await _latest_profile(db, user)
    dims = (profile.dimensions if profile else None) or {}

    signals = []
    acc = 0.0
    total_w = 0.0
    for key, dim, weight, icon in _SIGNALS:
        value = round(_health(dim, dims.get(dim, BASELINES[dim])))
        w = _WEIGHTS[weight]
        acc += value * w
        total_w += w
        signals.append(
            {"key": key, "value": value, "weight": weight, "icon": icon}
        )
    score = round(acc / total_w) if total_w else 0

    spark = await _spark(db, user)
    weekly_change = (spark[-1] - spark[0]) if len(spark) >= 2 else 0
    # Blend the mood-proxy slope toward the score so the hero reads sensibly.
    weekly_change = round(weekly_change * 0.4)
    trend = "up" if weekly_change > 1 else ("down" if weekly_change < -1 else "flat")

    return {
        "score": score,
        "band": _band(score),
        "trend": trend,
        "weekly_change": weekly_change,
        "confidence": round((profile.confidence if profile else 0.0) * 100),
        "signals": signals,
        "spark": spark or [score],
    }
