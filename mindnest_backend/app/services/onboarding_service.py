"""Onboarding → initial emotional baseline.

Maps the five-field intake to a dimension contribution, runs the scoring
engine, and persists a synthetic *completed* assessment + mood profile + the
10 ``EmotionalHistory`` rows (mirrors ``mood_service.complete_assessment``) so
the new user already has a real 10-dimension profile, trend substrate and an
initial recommendation set. Sets ``users.onboarded = True``.
"""
from __future__ import annotations

from sqlalchemy import select

from app.core.dimensions import (
    ANXIETY,
    BURNOUT,
    DIMENSIONS,
    FATIGUE,
    HAPPINESS,
    MOTIVATION,
    SADNESS,
    STRESS,
)
from app.core.utils import utcnow
from app.models import (
    Assessment,
    AssessmentStatus,
    EmotionalHistory,
    MoodProfile,
    OnboardingResponse,
    User,
)
from app.services import mood_service, recommendation_service, scoring


def _contributions(mood: int, stress: int, sleep: int, anxiety: int | None) -> list[dict]:
    """Translate the intake fields into per-field dimension contributions.

    Each field is its own contribution so a dimension touched by two fields
    (e.g. anxiety from both ``stress`` and the optional ``anxiety`` field)
    accrues multiple signals — which the scoring engine reads as agreement.
    """
    pos = (mood - 1) / 4.0        # 0 (low) .. 1 (great)
    sfrac = stress / 10.0         # 0 .. 1
    spoor = (5 - sleep) / 4.0     # 0 (great sleep) .. 1 (poor sleep)

    raw: list[dict[str, float]] = [
        {  # mood → happiness / motivation / sadness
            HAPPINESS: round((pos - 0.5) * 70.0, 1),
            MOTIVATION: round((pos - 0.5) * 50.0, 1),
            SADNESS: round((1 - pos) * 50.0, 1),
        },
        {  # stress → stress / anxiety
            STRESS: round(sfrac * 75.0, 1),
            ANXIETY: round(sfrac * 28.0, 1),
        },
        {  # poor sleep → fatigue / burnout
            FATIGUE: round(spoor * 60.0, 1),
            BURNOUT: round(spoor * 35.0, 1),
        },
    ]
    if anxiety is not None:
        raw.append({ANXIETY: round((anxiety / 3.0) * 45.0, 1)})

    out = []
    for dims in raw:
        kept = {d: v for d, v in dims.items() if abs(v) >= 0.5}
        if kept:
            out.append({"dimensions": kept})
    return out


async def status(db, user: User) -> dict:
    res = await db.execute(
        select(OnboardingResponse).where(OnboardingResponse.user_id == user.id)
    )
    ob = res.scalar_one_or_none()
    return {
        "onboarded": bool(user.onboarded),
        "completed": ob is not None,
        "goals": (ob.goals if ob else []) or [],
        "focus_areas": (ob.focus_areas if ob else []) or [],
    }


async def submit(db, user: User, payload) -> dict:
    contributions = _contributions(
        payload.mood, payload.stress, payload.sleep, payload.anxiety
    )
    state = scoring.aggregate(contributions)
    summary = mood_service._template_summary(state)

    assessment = Assessment(
        user_id=user.id,
        status=AssessmentStatus.COMPLETED,
        stage="baseline",
        question_count=len(contributions),
        completed_at=utcnow(),
        meta={"source": "onboarding", "template": "onboarding"},
    )
    db.add(assessment)
    await db.flush()  # assign assessment.id for the FKs below

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

    res = await db.execute(
        select(OnboardingResponse).where(OnboardingResponse.user_id == user.id)
    )
    ob = res.scalar_one_or_none()
    if ob is None:
        ob = OnboardingResponse(user_id=user.id)
        db.add(ob)
    ob.mood = payload.mood
    ob.stress = payload.stress
    ob.sleep = payload.sleep
    ob.anxiety = payload.anxiety
    ob.goals = payload.goals or []
    ob.focus_areas = payload.focus_areas or []
    ob.seeded_assessment_id = assessment.id

    user.onboarded = True
    await db.commit()
    await db.refresh(profile)

    recs = await recommendation_service.regenerate(db, user)

    return {
        "onboarded": True,
        **mood_service.profile_to_summary(profile),
        "recommendations": recs,
    }
