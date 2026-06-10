"""Assessment orchestration: ties the DB, the adaptive engine, the
scoring engine and the AI text pipeline together.

State is always recomputed from stored answers (each answer caches its
own dimension contribution in ``Answer.derived``), so the flow is
idempotent and we never re-run the NLP models for a past answer.
"""
from __future__ import annotations

from fastapi import HTTPException, status
from sqlalchemy import select

from app.ai import pipeline
from app.models import Answer, Assessment, AssessmentStatus, MoodProfile, User
from app.services import assessment_templates as templates
from app.services import questionnaire_engine as engine
from app.services import scoring


# ---- loading / state ---------------------------------------------------------


async def get_owned_assessment(db, user: User, assessment_id: str) -> Assessment:
    res = await db.execute(select(Assessment).where(Assessment.id == assessment_id))
    assessment = res.scalar_one_or_none()
    if assessment is None or assessment.user_id != user.id:
        raise HTTPException(status.HTTP_404_NOT_FOUND, "Assessment not found")
    return assessment


async def _load_answers(db, assessment_id: str) -> list[Answer]:
    res = await db.execute(
        select(Answer)
        .where(Answer.assessment_id == assessment_id)
        .order_by(Answer.order_index)
    )
    return list(res.scalars().all())


def compute_state(answers: list[Answer]) -> dict:
    contributions = [a.derived or {"dimensions": {}} for a in answers]
    return scoring.aggregate(contributions)


def _engine_answers(answers: list[Answer]) -> list[dict]:
    return [{"question_id": a.question_id, "raw": a.raw_value or {}} for a in answers]


def _progress(count: int, done: bool, cfg: dict) -> dict:
    max_q = cfg["max_questions"]
    if done:
        frac = 1.0
    else:
        frac = min(0.95, count / max(max_q, 1))
    return {
        "answered": count,
        "min": cfg["min_questions"],
        "max": max_q,
        "fraction": round(frac, 2),
    }


def _interim_top(state: dict, k: int = 3) -> list[dict]:
    return [
        {
            "dimension": t["dimension"],
            "label": t["label"],
            "score": t["score"],
            "elevated": t["elevated"],
        }
        for t in state["top_emotions"][:k]
    ]


def build_next_payload(assessment: Assessment, answers: list[Answer]) -> dict:
    cfg = templates.config_for((assessment.meta or {}).get("template"))
    state = compute_state(answers)
    question, reason = engine.select_next_question(
        _engine_answers(answers), state, config=cfg
    )
    done = question is None
    return {
        "assessment_id": assessment.id,
        "done": done,
        "question": engine.public_question(question, reason) if question else None,
        "progress": _progress(len(answers), done, cfg),
        "interim_top": _interim_top(state),
    }


# ---- mutations ---------------------------------------------------------------


async def start_assessment(db, user: User, meta: dict, template: str | None = None) -> dict:
    template_id = templates.resolve(template)
    meta = {**(meta or {}), "template": template_id}
    assessment = Assessment(user_id=user.id, meta=meta)
    db.add(assessment)
    await db.commit()
    await db.refresh(assessment)
    return build_next_payload(assessment, [])


async def record_answer(db, user: User, assessment_id: str, answer_req) -> dict:
    assessment = await get_owned_assessment(db, user, assessment_id)
    if assessment.status != AssessmentStatus.IN_PROGRESS:
        raise HTTPException(status.HTTP_409_CONFLICT, "Assessment already completed")

    question = engine.get_bank().get(answer_req.question_id)
    if question is None:
        raise HTTPException(status.HTTP_400_BAD_REQUEST, "Unknown question_id")

    raw = answer_req.to_raw()

    # Run the AI text pipeline for free-text / journal answers.
    nlp_result = None
    if question["type"] in ("free_text", "journal") and not raw.get("skipped"):
        text = raw.get("text", "")
        if text:
            nlp_result = pipeline.analyze_text(text, focus=question.get("nlp_focus"))

    contribution = scoring.score_answer(question, raw, nlp_result)

    answers = await _load_answers(db, assessment_id)
    existing = next((a for a in answers if a.question_id == answer_req.question_id), None)
    if existing is not None:
        existing.raw_value = raw
        existing.derived = contribution
    else:
        db.add(Answer(
            assessment_id=assessment_id,
            question_id=answer_req.question_id,
            order_index=len(answers),
            raw_value=raw,
            derived=contribution,
        ))

    await db.flush()
    answers = await _load_answers(db, assessment_id)
    assessment.question_count = len(answers)
    assessment.stage = _current_stage(answers)
    await db.commit()

    payload = build_next_payload(assessment, answers)
    payload["accepted"] = True
    return payload


async def next_question(db, user: User, assessment_id: str) -> dict:
    assessment = await get_owned_assessment(db, user, assessment_id)
    answers = await _load_answers(db, assessment_id)
    return build_next_payload(assessment, answers)


def _current_stage(answers: list[Answer]) -> str:
    if not answers:
        return "baseline"
    bank = engine.get_bank()
    last = bank.get(answers[-1].question_id)
    return (last or {}).get("stage", "baseline")


# ---- completed history -------------------------------------------------------


async def completed_history(db, user: User, limit: int = 30) -> list[dict]:
    """Completed assessments (most recent first) with their template + summary."""
    res = await db.execute(
        select(MoodProfile, Assessment.meta)
        .join(Assessment, Assessment.id == MoodProfile.assessment_id)
        .where(MoodProfile.user_id == user.id)
        .order_by(MoodProfile.created_at.desc())
        .limit(limit)
    )
    out: list[dict] = []
    for profile, meta in res.all():
        out.append({
            "assessment_id": profile.assessment_id,
            "template": (meta or {}).get("template", templates.DEFAULT_TEMPLATE),
            "source": (meta or {}).get("source", "assessment"),
            "created_at": profile.created_at,
            "overall_mood": profile.overall_mood,
            "valence": profile.valence,
            "confidence": profile.confidence,
            "top_emotions": profile.top_emotions or [],
        })
    return out
