"""Analytics orchestration: load data, call the pure analytics modules.

Keeps the AI compute (``ai/analytics/*``) pure and DB-free; this layer does the
loading and shaping. Shared loader so timeline + patterns read the same window.
"""
from __future__ import annotations

from collections import Counter
from datetime import timedelta

from sqlalchemy import select

from app.ai.analytics import emotional_timeline, pattern_detector
from app.core.utils import utcnow
from app.models import Journal, JournalAnalysis, MoodEntry, User
from app.services import insights_service, mood_factors


async def _load(db, user: User, days: int) -> tuple[list[dict], list[dict]]:
    cutoff = utcnow() - timedelta(days=days)

    jres = await db.execute(
        select(Journal, JournalAnalysis)
        .outerjoin(JournalAnalysis, JournalAnalysis.journal_id == Journal.id)
        .where(
            Journal.user_id == user.id,
            Journal.draft.is_(False),
            Journal.created_at >= cutoff,
        )
    )
    journal_items = []
    for _journal, analysis in jres.all():
        topics = [t.get("name") for t in (analysis.topics or [])] if analysis else []
        journal_items.append({
            "concerns": bool(analysis and analysis.concerns),
            "topics": [t for t in topics if t],
        })

    mres = await db.execute(
        select(MoodEntry.level, MoodEntry.factors).where(
            MoodEntry.user_id == user.id, MoodEntry.created_at >= cutoff
        )
    )
    mood_items = []
    for level, factors in mres.all():
        mood_items.append({
            "level": level,
            "factors": [
                {"key": k, "label": mood_factors.label_for(k)} for k in (factors or [])
            ],
        })
    return journal_items, mood_items


def _drivers(journal_items: list[dict], mood_items: list[dict]) -> list[dict]:
    counts: Counter = Counter()
    kind: dict[str, str] = {}
    for j in journal_items:
        for name in j["topics"]:
            counts[name] += 1
            kind[name] = "topic"
    for m in mood_items:
        for f in m["factors"]:
            counts[f["label"]] += 1
            kind.setdefault(f["label"], "factor")
    return [
        {"name": name, "count": cnt, "kind": kind[name]}
        for name, cnt in counts.most_common()
    ]


async def emotional_timeline_view(db, user: User, *, days: int = 30) -> dict:
    trends = (await insights_service.trends(db, user, days=days))["trends"]
    journal_items, mood_items = await _load(db, user, days)
    drivers = _drivers(journal_items, mood_items)
    return emotional_timeline.build(trends, drivers, days)


async def patterns_view(db, user: User, *, days: int = 30) -> dict:
    journal_items, mood_items = await _load(db, user, days)
    cards = pattern_detector.detect(journal_items, mood_items)
    return {"days": days, "patterns": cards}
