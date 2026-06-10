"""The home dashboard aggregate (wellness-only — no appointments/therapists).

Pulls the latest mood, emotional profile, streak, weekly trend, latest cached
insight, top recommendations and the most recent journal into one payload.
Reads run sequentially on the request session (an AsyncSession is not safe to
share across concurrent awaits); each read is a cheap indexed lookup.
"""
from __future__ import annotations

from datetime import timedelta

from sqlalchemy import select

from app.core.dimensions import DIMENSION_LABELS, DIMENSIONS, is_high
from app.core.time_format import day_levels
from app.core.utils import utcnow
from app.models import Journal, MoodEntry, MoodProfile, User
from app.services import (
    insights_view_service,
    journal_service,
    recommendation_service,
    streak_service,
)


async def _latest_profile(db, user: User) -> MoodProfile | None:
    res = await db.execute(
        select(MoodProfile)
        .where(MoodProfile.user_id == user.id)
        .order_by(MoodProfile.created_at.desc())
        .limit(1)
    )
    return res.scalar_one_or_none()


async def _latest_entry(db, user: User) -> MoodEntry | None:
    res = await db.execute(
        select(MoodEntry)
        .where(MoodEntry.user_id == user.id)
        .order_by(MoodEntry.created_at.desc())
        .limit(1)
    )
    return res.scalar_one_or_none()


async def _weekly_trend(db, user: User) -> list[int]:
    cutoff = utcnow() - timedelta(days=8)
    res = await db.execute(
        select(MoodEntry.created_at, MoodEntry.level)
        .where(MoodEntry.user_id == user.id, MoodEntry.created_at >= cutoff)
        .order_by(MoodEntry.created_at)
    )
    pairs = [(row[0], row[1]) for row in res.all()]
    return day_levels(pairs, days=7)


async def _recent_journal(db, user: User) -> Journal | None:
    res = await db.execute(
        select(Journal)
        .where(Journal.user_id == user.id, Journal.draft.is_(False))
        .order_by(Journal.created_at.desc())
        .limit(1)
    )
    return res.scalar_one_or_none()


def _emotional_profile(profile: MoodProfile | None) -> dict | None:
    if profile is None:
        return None
    dims = profile.dimensions or {}
    return {
        "overall_mood": profile.overall_mood,
        "valence": profile.valence,
        "confidence": profile.confidence,
        "top_emotions": profile.top_emotions or [],
        "dimensions": [
            {
                "dimension": d,
                "label": DIMENSION_LABELS[d],
                "score": dims.get(d, 0.0),
                "elevated": is_high(d, dims.get(d, 0.0)),
            }
            for d in DIMENSIONS
        ],
    }


async def dashboard(db, user: User) -> dict:
    profile = await _latest_profile(db, user)
    entry = await _latest_entry(db, user)
    streak = await streak_service.get_streak(db, user)
    weekly = await _weekly_trend(db, user)
    recs = await recommendation_service.list_active(db, user)
    journal = await _recent_journal(db, user)

    latest_insight = await insights_view_service.latest_cached(db, user)
    if latest_insight is None:
        # Generate a weekly window once so the card isn't empty.
        latest_insight = await insights_view_service.generate(db, user, "weekly")

    current_mood = {
        "level": entry.level if entry else None,
        "label": profile.overall_mood if profile else "No check-ins yet",
        "valence": profile.valence if profile else 0.0,
    }

    insight_card = None
    if latest_insight:
        msgs = latest_insight.get("insights") or []
        insight_card = {
            "headline": latest_insight.get("headline", ""),
            "body": msgs[0] if msgs else "",
            "generated_at": latest_insight.get("generated_at"),
        }

    return {
        "display_name": user.display_name,
        "current_mood": current_mood,
        "emotional_profile": _emotional_profile(profile),
        "streak": {
            "current": streak.current if streak else 0,
            "longest": streak.longest if streak else 0,
            "goal": streak.goal if streak else (getattr(user, "streak_goal", 7) or 7),
        },
        "weekly_trend": weekly,
        "latest_insight": insight_card,
        "recommendations": [
            {
                "id": r.id, "kind": r.kind, "title": r.title, "body": r.body,
                "score": r.score, "reason": r.reason, "status": r.status,
                "source": r.source or {}, "created_at": r.created_at,
            }
            for r in recs[:3]
        ],
        "recent_journal": journal_service.to_out(journal) if journal else None,
    }
