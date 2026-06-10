"""Long-term memory: trends, emotional drift, burnout progression and
weekly insights — all computed from the stored ``EmotionalHistory`` and
``MoodProfile`` rows. Deterministic and offline (no model required).
"""
from __future__ import annotations

from datetime import timedelta

from sqlalchemy import select

from app.core.dimensions import DIMENSION_LABELS, DIMENSIONS, POSITIVE_DIMENSIONS
from app.core.utils import utcnow
from app.models import EmotionalHistory, MoodProfile, User

_STABLE_EPS = 5.0


def _direction(delta: float) -> str:
    if abs(delta) < _STABLE_EPS:
        return "stable"
    return "rising" if delta > 0 else "falling"


async def trends(db, user: User, days: int = 30) -> dict:
    cutoff = utcnow() - timedelta(days=days)
    res = await db.execute(
        select(EmotionalHistory)
        .where(EmotionalHistory.user_id == user.id,
               EmotionalHistory.created_at >= cutoff)
        .order_by(EmotionalHistory.created_at)
    )
    rows = list(res.scalars().all())

    by_dim: dict[str, list[EmotionalHistory]] = {d: [] for d in DIMENSIONS}
    for r in rows:
        by_dim.setdefault(r.dimension, []).append(r)

    samples = len({r.assessment_id for r in rows})
    out_trends = []
    for d in DIMENSIONS:
        series = by_dim.get(d, [])
        if not series:
            continue
        points = [
            {"created_at": r.created_at, "score": r.score, "confidence": r.confidence}
            for r in series
        ]
        current = series[-1].score
        previous = series[-2].score if len(series) >= 2 else None
        first = series[0].score
        delta = current - (previous if previous is not None else current)
        out_trends.append({
            "dimension": d,
            "label": DIMENSION_LABELS[d],
            "points": points,
            "current": round(current, 1),
            "previous": round(previous, 1) if previous is not None else None,
            "delta": round(delta, 1),
            "direction": _direction(delta),
            "drift": round(current - first, 1),
        })

    return {"days": days, "samples": samples, "trends": out_trends}


async def _burnout_series(db, user: User, cutoff) -> list[dict]:
    res = await db.execute(
        select(MoodProfile)
        .where(MoodProfile.user_id == user.id, MoodProfile.created_at >= cutoff)
        .order_by(MoodProfile.created_at)
    )
    out = []
    for p in res.scalars().all():
        out.append({
            "created_at": p.created_at,
            "value": float((p.derived or {}).get("burnout_risk", 0.0)),
        })
    return out


async def insights(db, user: User, days: int = 7) -> dict:
    cutoff = utcnow() - timedelta(days=days)
    t = await trends(db, user, days=days)
    trend_by_dim = {x["dimension"]: x for x in t["trends"]}
    samples = t["samples"]

    burnout_pts = await _burnout_series(db, user, cutoff)
    burnout_first = burnout_pts[0]["value"] if burnout_pts else 0.0
    burnout_last = burnout_pts[-1]["value"] if burnout_pts else 0.0
    burnout = {
        "points": burnout_pts,
        "first": round(burnout_first, 1),
        "last": round(burnout_last, 1),
        "delta": round(burnout_last - burnout_first, 1),
        "direction": _direction(burnout_last - burnout_first),
    }

    messages: list[str] = []

    if samples < 2:
        headline = "Keep checking in to unlock your trends."
        messages.append(
            "You need a couple more check-ins before MindNest can spot patterns. "
            "Even a quick daily check-in builds a useful picture."
        )
        return _wrap(days, samples, headline, messages, burnout)

    # Drift-based observations.
    def drift_msg(dim: str, rising_is_bad: bool) -> str | None:
        tr = trend_by_dim.get(dim)
        if not tr:
            return None
        drift = tr["drift"]
        if abs(drift) < 8:
            return None
        label = DIMENSION_LABELS[dim].lower()
        if drift > 0:
            verb = "climbed" if rising_is_bad else "improved"
            mood = "worth keeping an eye on" if rising_is_bad else "a good sign"
            return f"Your {label} has {verb} about {abs(drift):.0f} points this week — {mood}."
        verb = "eased" if rising_is_bad else "dipped"
        mood = "a positive shift" if rising_is_bad else "worth gentle attention"
        return f"Your {label} has {verb} about {abs(drift):.0f} points this week — {mood}."

    for dim in ("stress", "anxiety", "sadness", "loneliness", "fatigue", "anger"):
        m = drift_msg(dim, rising_is_bad=True)
        if m:
            messages.append(m)
    for dim in ("happiness", "motivation"):
        m = drift_msg(dim, rising_is_bad=False)
        if m:
            messages.append(m)

    if burnout["delta"] >= 8:
        messages.append(
            f"Burnout risk is trending up (+{burnout['delta']:.0f}). Consider "
            "protecting recovery time before it builds further."
        )
    elif burnout["delta"] <= -8:
        messages.append(
            f"Burnout risk is easing ({burnout['delta']:.0f}). Whatever you're "
            "doing for recovery seems to be helping."
        )

    if not messages:
        messages.append("Your emotional signals have been fairly steady this week.")

    headline = _headline(trend_by_dim, burnout)
    return _wrap(days, samples, headline, messages, burnout)


def _headline(trend_by_dim: dict, burnout: dict) -> str:
    if burnout["last"] >= 60:
        return "Burnout risk is elevated — recovery matters this week."
    worst = None
    worst_val = 0.0
    for dim, tr in trend_by_dim.items():
        salience = (100 - tr["current"]) if dim in POSITIVE_DIMENSIONS else tr["current"]
        if salience > worst_val:
            worst_val, worst = salience, dim
    if worst and worst_val >= 55:
        return f"{DIMENSION_LABELS[worst]} stands out this week."
    return "A fairly balanced week overall."


def _wrap(days, samples, headline, messages, burnout) -> dict:
    return {
        "period_days": days,
        "samples": samples,
        "headline": headline,
        "insights": messages,
        "burnout_progression": burnout,
        "generated_at": utcnow(),
    }
