"""Seed a demo user with a two-week emotional storyline.

Run from the project root:

    python -m scripts.seed_demo

Creates / resets the user demo@mindnest.app (password: demo12345) and
backfills a series of completed assessments whose timestamps span the
last ~14 days — so /profile/trends and /profile/insights have a rich,
realistic arc to render immediately (balanced → rising stress →
burnout peak → recovery → steady).
"""
from __future__ import annotations

import asyncio
import json
from datetime import timedelta
from pathlib import Path

from sqlalchemy import delete, select

from app.core.dimensions import BASELINES, DIMENSIONS
from app.core.security import hash_password
from app.core.utils import utcnow
from app.database import AsyncSessionLocal, init_db
from app.models import (
    Answer,
    Assessment,
    AssessmentStatus,
    Embedding,
    EmotionalHistory,
    MoodProfile,
    Session,
    User,
)
from app.services import scoring
from app.services.mood_service import _template_summary
from app.services.seed import seed_questions

DEMO_EMAIL = "demo@mindnest.app"
DEMO_PASSWORD = "demo12345"

# (days_ago, scenario_name) — a narrative arc.
TIMELINE = [
    (14, "Balanced"),
    (12, "Balanced"),
    (10, "Rising stress"),
    (8, "Rising stress"),
    (6, "Burnout peak"),
    (5, "Low and withdrawn"),
    (4, "Burnout peak"),
    (3, "Recovering"),
    (2, "Recovering"),
    (1, "Back to steady"),
    (0, "Back to steady"),
]


def _load_scenarios() -> dict[str, dict]:
    path = Path(__file__).resolve().parent.parent / "app" / "data" / "sample_dataset.json"
    data = json.loads(path.read_text(encoding="utf-8"))
    return {s["name"]: s["targets"] for s in data["scenarios"]}


def _state_for(targets: dict[str, float]) -> dict:
    # One contribution that lands each dimension on its target.
    contribution = {"dimensions": {
        d: round(targets.get(d, BASELINES[d]) - BASELINES[d], 1) for d in DIMENSIONS
    }}
    return scoring.aggregate([contribution])


async def _reset_user(db, user: User) -> None:
    for model in (EmotionalHistory, MoodProfile, Embedding, Session):
        await db.execute(delete(model).where(model.user_id == user.id))
    # answers -> assessments
    res = await db.execute(select(Assessment.id).where(Assessment.user_id == user.id))
    aids = [r[0] for r in res.all()]
    if aids:
        await db.execute(delete(Answer).where(Answer.assessment_id.in_(aids)))
        await db.execute(delete(Assessment).where(Assessment.id.in_(aids)))
    await db.commit()


async def main() -> None:
    await init_db()
    scenarios = _load_scenarios()

    async with AsyncSessionLocal() as db:
        await seed_questions(db)

        res = await db.execute(select(User).where(User.email == DEMO_EMAIL))
        user = res.scalar_one_or_none()
        if user is None:
            user = User(
                email=DEMO_EMAIL,
                hashed_password=hash_password(DEMO_PASSWORD),
                display_name="Demo",
            )
            db.add(user)
            await db.commit()
            await db.refresh(user)
        else:
            await _reset_user(db, user)

        for days_ago, name in TIMELINE:
            targets = scenarios[name]
            state = _state_for(targets)
            when = utcnow() - timedelta(days=days_ago, hours=9)

            assessment = Assessment(
                user_id=user.id,
                status=AssessmentStatus.COMPLETED,
                stage="completed",
                question_count=8,
                started_at=when,
                completed_at=when,
                meta={"demo": True, "scenario": name},
            )
            db.add(assessment)
            await db.flush()

            db.add(MoodProfile(
                user_id=user.id,
                assessment_id=assessment.id,
                created_at=when,
                overall_mood=state["overall_mood"],
                valence=state["valence"],
                arousal=state["arousal"],
                confidence=state["overall_confidence"],
                dimensions=state["scores"],
                dimension_confidence=state["confidence"],
                derived=state["derived"],
                top_emotions=state["top_emotions"],
                contradictions=state["contradictions"],
                summary=_template_summary(state),
                summary_source="seed",
            ))
            for dim in DIMENSIONS:
                db.add(EmotionalHistory(
                    user_id=user.id,
                    assessment_id=assessment.id,
                    dimension=dim,
                    score=state["scores"][dim],
                    confidence=state["confidence"].get(dim, 0.0),
                    created_at=when,
                ))

        await db.commit()

    print("✅ Demo data seeded.")
    print(f"   Login:    {DEMO_EMAIL}")
    print(f"   Password: {DEMO_PASSWORD}")
    print(f"   History:  {len(TIMELINE)} check-ins across ~14 days")
    print("   Try:      GET /api/v1/profile/trends  and  /api/v1/profile/insights")


if __name__ == "__main__":
    asyncio.run(main())
