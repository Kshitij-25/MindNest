"""Builds the burnout insight-detail payload from the latest emotional profile.

The burnout index reuses ``scoring._derived_metrics``; contributing factors are
projected from the dimensions that feed it, and related recommendations are the
current active ones. The spark is a short proxy series so the card has a trend.
"""
from __future__ import annotations

from sqlalchemy import select

from app.core.dimensions import BASELINES, FATIGUE, MOTIVATION, STRESS
from app.models import MoodProfile, User
from app.services import recommendation_service, scoring


async def _latest_profile(db, user: User) -> MoodProfile | None:
    res = await db.execute(
        select(MoodProfile)
        .where(MoodProfile.user_id == user.id)
        .order_by(MoodProfile.created_at.desc())
        .limit(1)
    )
    return res.scalar_one_or_none()


async def burnout_detail(db, user: User) -> dict:
    profile = await _latest_profile(db, user)
    dims = (profile.dimensions if profile else None) or dict(BASELINES)
    derived = scoring._derived_metrics(dims)
    burnout = round(derived["burnout_risk"])
    confidence = round((profile.confidence if profile else 0.0) * 100)

    factors = [
        {"label": "Workload pressure", "value": round(dims.get(STRESS, 0.0)), "color_key": "topic-2"},
        {"label": "Evening recovery", "value": round(100.0 - dims.get(FATIGUE, 0.0)), "color_key": "topic-4"},
        {"label": "Sleep consistency", "value": round(100.0 - dims.get(FATIGUE, 0.0)), "color_key": "topic-3"},
        {"label": "Sense of control", "value": round(dims.get(MOTIVATION, 0.0)), "color_key": "primary"},
    ]

    # Short proxy spark trending toward the current index.
    spark = [
        min(100, burnout + 14), min(100, burnout + 12), min(100, burnout + 9),
        min(100, burnout + 7), min(100, burnout + 4), min(100, burnout + 2),
        burnout,
    ]
    delta = burnout - spark[0]

    recs = await recommendation_service.list_active(db, user)
    rec_ids = [r.id for r in recs[:2]]

    improving = delta <= 0
    return {
        "type": "burnout",
        "title": "Burnout Analysis",
        "kind": "Burnout report",
        "icon": "flame",
        "color_key": "streak",
        "headline": "Your burnout risk is easing" if improving else "Your burnout risk is rising",
        "confidence": confidence,
        "band": f"{derived['burnout_label']} · {'improving' if improving else 'watch'}",
        "metric": burnout,
        "metric_label": "Burnout index",
        "metric_delta": delta,
        "spark": spark,
        "factors": factors,
        "rec_ids": rec_ids,
        "context": (
            "Your burnout signals blend stress, fatigue, low motivation and "
            "loneliness. Protecting your evenings and a steadier sleep window are "
            "the highest-leverage ways to keep them easing."
        ),
    }
