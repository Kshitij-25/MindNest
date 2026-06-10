"""Profile aggregation + settings.

Profile reads pull lightweight counts straight from the wellness tables (the
same inline-query idiom used by ``mood_service``/``insights_service``). Settings
merge user overrides over the feature-flag defaults.
"""
from __future__ import annotations

from datetime import timedelta

from pydantic.alias_generators import to_camel, to_snake
from sqlalchemy import func, select

from app.core.feature_flags import DEFAULT_FLAGS, merged_flags
from app.core.time_format import day_levels
from app.core.utils import utcnow
from app.models import (
    Assessment,
    AssessmentStatus,
    HabitLog,
    Journal,
    MoodEntry,
    Streak,
    User,
)


async def _count_since(db, model, user_id: str, cutoff, **filters) -> int:
    stmt = select(func.count()).select_from(model).where(model.user_id == user_id)
    if cutoff is not None and hasattr(model, "created_at"):
        stmt = stmt.where(model.created_at >= cutoff)
    for k, v in filters.items():
        stmt = stmt.where(getattr(model, k) == v)
    return int((await db.execute(stmt)).scalar() or 0)


async def _streak_value(db, user_id: str) -> int:
    res = await db.execute(select(Streak).where(Streak.user_id == user_id))
    s = res.scalar_one_or_none()
    return s.current if s else 0


async def mood_week(db, user_id: str) -> list[int]:
    cutoff = utcnow() - timedelta(days=8)
    res = await db.execute(
        select(MoodEntry.created_at, MoodEntry.level)
        .where(MoodEntry.user_id == user_id, MoodEntry.created_at >= cutoff)
        .order_by(MoodEntry.created_at)
    )
    pairs = [(row[0], row[1]) for row in res.all()]
    return day_levels(pairs, days=7)


async def profile(db, user: User) -> dict:
    week_cutoff = utcnow() - timedelta(days=7)

    total_checkins = await _count_since(db, MoodEntry, user.id, cutoff=None)
    total_entries = await _count_since(db, Journal, user.id, cutoff=None, draft=False)

    wk_checkins = await _count_since(db, MoodEntry, user.id, cutoff=week_cutoff)
    wk_entries = await _count_since(db, Journal, user.id, cutoff=week_cutoff, draft=False)
    wk_assess = await _count_since(
        db, Assessment, user.id, cutoff=week_cutoff, status=AssessmentStatus.COMPLETED
    )
    wk_habits_res = await db.execute(
        select(func.count()).select_from(HabitLog).where(
            HabitLog.user_id == user.id,
            HabitLog.done.is_(True),
            HabitLog.created_at >= week_cutoff,
        )
    )
    wk_habits = int(wk_habits_res.scalar() or 0)

    streak = await _streak_value(db, user.id)

    week_activity = [
        {"icon": "heart", "value": str(wk_checkins), "label": "Check-ins", "color_key": "clay"},
        {"icon": "feather", "value": str(wk_entries), "label": "Journal entries", "color_key": "topic4"},
        {"icon": "activity", "value": str(wk_assess), "label": "Assessments", "color_key": "primary"},
        {"icon": "checkCircle", "value": str(wk_habits), "label": "Habits done", "color_key": "topic1"},
    ]

    return {
        "id": user.id,
        "name": user.display_name or user.email.split("@")[0],
        "email": user.email,
        "avatar_url": user.avatar_url,
        "about": user.about,
        "phone": user.phone,
        "onboarded": user.onboarded,
        "check_ins": str(total_checkins),
        "entries": str(total_entries),
        "streak": str(streak),
        "week_activity": week_activity,
        "mood_week": await mood_week(db, user.id),
    }


async def update_profile(db, user: User, patch) -> dict:
    if patch.name is not None:
        user.display_name = patch.name
    if patch.avatar_url is not None:
        user.avatar_url = patch.avatar_url
    if patch.about is not None:
        user.about = patch.about
    if patch.phone is not None:
        user.phone = patch.phone
    await db.commit()
    await db.refresh(user)
    return await profile(db, user)


# ---- settings ----------------------------------------------------------------


def get_settings(user: User) -> dict:
    """Flag keys are emitted camelCase (``enableJournalAi``) for the client."""
    s = user.settings or {}
    merged = merged_flags(s)
    return {
        "feature_flags": {to_camel(k): v for k, v in merged.items()},
        "theme": s.get("theme", "system"),
    }


async def update_settings(db, user: User, patch) -> dict:
    s = dict(user.settings or {})
    if patch.theme is not None:
        s["theme"] = patch.theme
    if patch.feature_flags is not None:
        flags = dict(s.get("feature_flags") or {})
        for raw_key, v in patch.feature_flags.items():
            key = to_snake(raw_key)  # accept camelCase or snake_case
            if key in DEFAULT_FLAGS:
                flags[key] = bool(v)
        s["feature_flags"] = flags
    user.settings = s
    await db.commit()
    await db.refresh(user)
    return get_settings(user)


def flag_catalog(user: User) -> dict:
    merged = merged_flags(user.settings)
    return {
        "flags": [
            {"key": to_camel(k), "value": merged[k], "default": DEFAULT_FLAGS[k]}
            for k in DEFAULT_FLAGS
        ]
    }
