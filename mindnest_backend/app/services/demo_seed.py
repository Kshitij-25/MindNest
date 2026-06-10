"""Seed local demo content (topics reference + a demo wellness user).

Idempotent and dev-gated (``settings.SEED_DEMO_CONTENT``). Topics are merged on
every startup; the demo user + storyline are created only once (skipped if the
user already exists). The arc reuses the sample scenarios so trends, insights,
the dashboard, reports and pattern cards all render immediately.
"""
from __future__ import annotations

import json
import logging
from datetime import timedelta
from pathlib import Path

from sqlalchemy import select

from app.ai.journaling import analyzer
from app.ai.journaling.topics import TOPIC_VOCAB, color_key
from app.ai.memory import store as memory_store
from app.core.dimensions import BASELINES, DIMENSIONS
from app.core.security import hash_password
from app.core.utils import utcnow
from app.models import (
    Assessment,
    AssessmentStatus,
    EmotionalHistory,
    Habit,
    HabitLog,
    Journal,
    JournalAnalysis,
    JournalAnalysisStatus,
    MoodEntry,
    MoodProfile,
    Notification,
    Streak,
    Topic,
    User,
)
from app.services import recommendation_service, scoring
from app.services.mood_service import _template_summary

logger = logging.getLogger("mindnest.seed")

DEMO_EMAIL = "demo@mindnest.app"
DEMO_PASSWORD = "demo12345"

# (days_ago, scenario, mood level 1-5, factors, optional note)
_TIMELINE = [
    (14, "Balanced", 4, ["exercise", "social"], ""),
    (12, "Balanced", 4, ["rest"], ""),
    (10, "Rising stress", 3, ["work"], "Work is picking up and I'm feeling the pressure."),
    (8, "Rising stress", 3, ["work", "sleep"], ""),
    (6, "Burnout peak", 1, ["work", "sleep"], "Completely drained, can't keep up with deadlines."),
    (5, "Low and withdrawn", 2, ["relationships"], ""),
    (4, "Burnout peak", 1, ["work"], ""),
    (3, "Recovering", 3, ["rest", "exercise"], "Took some time for myself, feeling a bit better."),
    (2, "Recovering", 3, ["exercise"], ""),
    (1, "Back to steady", 4, ["social", "exercise"], ""),
    (0, "Back to steady", 4, ["exercise"], "Good day — feeling more like myself again."),
]

_JOURNAL_SEED = [
    (10, "reflection", 3, "A heavy week",
     "Work has been overwhelming and stressful. My boss keeps piling on deadlines "
     "and I feel anxious and exhausted most days."),
    (5, "free", 2, "",
     "Feeling low and withdrawn. I've been isolating myself and haven't reached out "
     "to friends. Lonely."),
    (1, "gratitude", 4, "Small wins",
     "Grateful for a calm weekend. Went for a run, saw a friend, and finally slept "
     "well. Feeling hopeful and a bit motivated again."),
]


def _load_scenarios() -> dict[str, dict]:
    path = Path(__file__).resolve().parent.parent / "data" / "sample_dataset.json"
    data = json.loads(path.read_text(encoding="utf-8"))
    return {s["name"]: s["targets"] for s in data["scenarios"]}


def _state_for(targets: dict[str, float]) -> dict:
    contribution = {"dimensions": {
        d: round(targets.get(d, BASELINES[d]) - BASELINES[d], 1) for d in DIMENSIONS
    }}
    return scoring.aggregate([contribution])


async def _seed_topics(db) -> None:
    for t in TOPIC_VOCAB:
        await db.merge(Topic(
            id=t["slug"],
            name=t["name"],
            topic_index=t["index"],
            color_key=color_key(t["index"]),
        ))
    await db.commit()


async def _seed_arc(db, user: User, scenarios: dict) -> None:
    for days_ago, name, level, factors, note in _TIMELINE:
        targets = scenarios[name]
        state = _state_for(targets)
        when = utcnow() - timedelta(days=days_ago, hours=9)

        assessment = Assessment(
            user_id=user.id,
            status=AssessmentStatus.COMPLETED,
            stage="baseline",
            question_count=1,
            started_at=when,
            completed_at=when,
            meta={"demo": True, "source": "checkin", "scenario": name},
        )
        db.add(assessment)
        await db.flush()

        db.add(MoodProfile(
            user_id=user.id, assessment_id=assessment.id, created_at=when,
            overall_mood=state["overall_mood"], valence=state["valence"],
            arousal=state["arousal"], confidence=state["overall_confidence"],
            dimensions=state["scores"], dimension_confidence=state["confidence"],
            derived=state["derived"], top_emotions=state["top_emotions"],
            contradictions=state["contradictions"], summary=_template_summary(state),
            summary_source="seed",
        ))
        for dim in DIMENSIONS:
            db.add(EmotionalHistory(
                user_id=user.id, assessment_id=assessment.id, dimension=dim,
                score=state["scores"][dim], confidence=state["confidence"].get(dim, 0.0),
                created_at=when,
            ))
        db.add(MoodEntry(
            user_id=user.id, level=level, factors=factors, note=note,
            dimension_deltas={d: state["scores"][d] for d in DIMENSIONS},
            assessment_id=assessment.id, created_at=when,
        ))
    await db.commit()


async def _seed_journals(db, user: User) -> None:
    for days_ago, kind, mood, title, body in _JOURNAL_SEED:
        when = utcnow() - timedelta(days=days_ago, hours=11)
        journal = Journal(
            user_id=user.id, kind=kind, mood=mood, title=title, body=body,
            draft=False, analysis_status=JournalAnalysisStatus.READY,
            created_at=when, updated_at=when,
        )
        db.add(journal)
        await db.flush()

        result = await analyzer.analyze(body)
        db.add(JournalAnalysis(
            journal_id=journal.id, user_id=user.id, emotion=result["emotion"],
            dimensions=result["dimensions"], summary=result["summary"],
            topics=result["topics"], themes=result["themes"],
            stressors=result["stressors"], wins=result["wins"],
            concerns=result["concerns"], suggestions=result["suggestions"],
            sources=result["sources"], model=result["model"], created_at=when,
        ))
        await memory_store.index_memory(
            db, user_id=user.id, kind="journal", ref_id=journal.id,
            text=body, summary=result["summary"], source="journal",
            journal_id=journal.id,
        )
    await db.commit()


async def _seed_habits(db, user: User) -> None:
    habits = [
        Habit(user_id=user.id, name="Morning meditation", kind="meditation",
              cadence="daily", target_dimension="stress"),
        Habit(user_id=user.id, name="Evening walk", kind="exercise", cadence="daily"),
    ]
    for h in habits:
        db.add(h)
    await db.flush()
    # Log the meditation habit on most of the recent days.
    today = utcnow().date()
    for i in range(0, 6):
        if i in (3,):   # one miss, so analytics has contrast
            continue
        db.add(HabitLog(
            habit_id=habits[0].id, user_id=user.id,
            date=today - timedelta(days=i), done=True,
        ))
    for i in range(0, 4):
        db.add(HabitLog(
            habit_id=habits[1].id, user_id=user.id,
            date=today - timedelta(days=i), done=True,
        ))
    await db.commit()


async def seed_demo_content(db) -> None:
    """Populate reference data + a demo user (idempotent)."""
    await _seed_topics(db)

    res = await db.execute(select(User).where(User.email == DEMO_EMAIL))
    if res.scalar_one_or_none() is not None:
        return  # already seeded

    scenarios = _load_scenarios()
    user = User(
        email=DEMO_EMAIL,
        hashed_password=hash_password(DEMO_PASSWORD),
        display_name="Demo",
        onboarded=True,
    )
    db.add(user)
    await db.commit()
    await db.refresh(user)

    await _seed_arc(db, user, scenarios)
    await _seed_journals(db, user)
    await _seed_habits(db, user)

    db.add(Streak(
        user_id=user.id, current=7, longest=7, goal=7,
        last_checkin_date=utcnow().date(),
    ))
    db.add(Notification(
        user_id=user.id, type="system",
        title="Welcome to MindNest 🌿",
        body="Your space for check-ins, journaling and gentle insight. Take a breath.",
    ))
    await db.commit()

    await recommendation_service.regenerate(db, user)
    logger.info("Demo user seeded: %s / %s", DEMO_EMAIL, DEMO_PASSWORD)
