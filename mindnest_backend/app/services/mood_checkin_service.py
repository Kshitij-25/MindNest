"""Mood check-in — the write path.

A check-in is the simple 1–5 + factors + note surface, but it feeds the full
engine: build contributions (level + factors + note NLP) → ``scoring.aggregate``
→ persist a ``MoodEntry`` AND a synthetic completed check-in ``Assessment`` +
``MoodProfile`` + 10 ``EmotionalHistory`` rows (so trends/drift/insights see
check-ins on one timeline) + an optional ``Embedding(source="checkin")``;
advance the streak; refresh recommendations. Mirrors the persistence in
``mood_service.complete_assessment`` and ``onboarding_service.submit``.
"""
from __future__ import annotations

from collections import defaultdict

from app.ai import pipeline
from app.ai.embeddings import embedder
from app.core.dimensions import DIMENSIONS
from app.core.utils import utcnow
from app.models import (
    Assessment,
    AssessmentStatus,
    Embedding,
    EmotionalHistory,
    MoodEntry,
    MoodProfile,
    User,
)
from app.services import (
    mood_factors,
    mood_service,
    recommendation_service,
    scoring,
    streak_service,
)


def _merged_deltas(contributions: list[dict]) -> dict:
    merged: dict[str, float] = defaultdict(float)
    for c in contributions:
        for d, v in (c.get("dimensions") or {}).items():
            merged[d] += v
    return {d: round(v, 1) for d, v in merged.items()}


async def checkin(db, user: User, payload) -> dict:
    level = payload.level
    factors = list(payload.factors or [])
    note = (payload.note or "").strip()

    contributions = [mood_factors.level_contribution(level)]
    contributions.extend(mood_factors.factor_contributions(level, factors))

    nlp = pipeline.analyze_text(note) if note else None
    if nlp and nlp.get("dimensions"):
        contributions.append({"dimensions": nlp["dimensions"]})

    state = scoring.aggregate(contributions)
    summary = mood_service._template_summary(state)

    assessment = Assessment(
        user_id=user.id,
        status=AssessmentStatus.COMPLETED,
        stage="baseline",
        question_count=len(contributions),
        completed_at=utcnow(),
        meta={"source": "checkin", "template": "daily_checkin",
              "level": level, "factors": factors},
    )
    db.add(assessment)
    await db.flush()

    profile = MoodProfile(
        user_id=user.id,
        assessment_id=assessment.id,
        overall_mood=state["overall_mood"],
        valence=state["valence"],
        arousal=state["arousal"],
        confidence=state["overall_confidence"],
        dimensions=state["scores"],
        dimension_confidence=state["confidence"],
        derived=state["derived"],
        top_emotions=state["top_emotions"],
        contradictions=state["contradictions"],
        summary=summary,
        summary_source="template",
    )
    db.add(profile)

    for dim in DIMENSIONS:
        db.add(EmotionalHistory(
            user_id=user.id,
            assessment_id=assessment.id,
            dimension=dim,
            score=state["scores"][dim],
            confidence=state["confidence"].get(dim, 0.0),
        ))

    entry = MoodEntry(
        user_id=user.id,
        level=level,
        factors=factors,
        note=note,
        dimension_deltas=_merged_deltas(contributions),
        assessment_id=assessment.id,
    )
    db.add(entry)
    await db.flush()

    if note:
        vec = embedder.embed(note)
        if vec:
            db.add(Embedding(
                user_id=user.id,
                source="checkin",
                mood_entry_id=entry.id,
                text=note[:2000],
                model=embedder._model.__class__.__name__ if embedder._model else "",
                dim=len(vec),
                vector=vec,
            ))

    streak = await streak_service.record_checkin(db, user)
    await db.commit()
    await db.refresh(entry)
    await db.refresh(streak)

    # Refresh recommendations off the new state (best-effort).
    await recommendation_service.regenerate(db, user)

    return {
        "id": entry.id,
        "level": entry.level,
        "factors": entry.factors or [],
        "note": entry.note or "",
        "created_at": entry.created_at,
        "overall_mood": state["overall_mood"],
        "valence": state["valence"],
        "top_emotions": state["top_emotions"],
        "streak": {
            "current": streak.current,
            "longest": streak.longest,
            "goal": streak.goal,
            "last_checkin_date": streak.last_checkin_date,
        },
    }
