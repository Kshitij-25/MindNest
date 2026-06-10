"""Coach grounding: assemble the user's current emotional context.

Pipeline order (per the product spec): memory retrieval → emotional profile →
recommendations. The result both prompts the LLM and is stored as the
``context_snapshot`` on the assistant turn (so a reply is always explainable).
Kept JSON-safe (no datetimes) so it can persist directly.
"""
from __future__ import annotations

from sqlalchemy import select

from app.ai.memory import retriever
from app.core.dimensions import (
    DIMENSION_LABELS,
    DIMENSIONS,
    POSITIVE_DIMENSIONS,
    is_high,
)
from app.models import MoodProfile, User
from app.services import recommendation_service


async def build(db, user: User, message: str) -> dict:
    res = await db.execute(
        select(MoodProfile)
        .where(MoodProfile.user_id == user.id)
        .order_by(MoodProfile.created_at.desc())
        .limit(1)
    )
    profile = res.scalar_one_or_none()

    mood = profile.overall_mood if profile else None
    valence = profile.valence if profile else 0.0
    concerns: list[str] = []
    if profile:
        dims = profile.dimensions or {}
        for d in DIMENSIONS:  # stable, valence-aware ordering
            sc = dims.get(d)
            if sc is None or not is_high(d, sc):
                continue
            label = DIMENSION_LABELS[d]
            concerns.append(f"low {label.lower()}" if d in POSITIVE_DIMENSIONS else label)
    top_emotions = [t.get("label") for t in (profile.top_emotions or [])][:3] if profile else []

    recs = await recommendation_service.list_active(db, user, regenerate_if_empty=False)
    rec_titles = [r.title for r in recs[:3]]

    memories = await retriever.search(db, user.id, message, top_k=3)

    return {
        "mood": mood,
        "valence": valence,
        "concerns": concerns[:4],
        "top_emotions": [e for e in top_emotions if e],
        "recommendations": rec_titles,
        "memories": [{"kind": m["kind"], "snippet": m["snippet"]} for m in memories],
    }
