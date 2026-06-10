"""Adaptive assessment endpoints."""
from __future__ import annotations

from fastapi import APIRouter, Depends, Query
from sqlalchemy.ext.asyncio import AsyncSession

from app.api.deps import get_current_user
from app.database import get_db
from app.models import User
from app.schemas.assessment import (
    AnswerAccepted,
    AnswerRequest,
    AssessmentHistoryItem,
    AssessmentSummary,
    AssessmentTemplateOut,
    NextQuestionOut,
    StartAssessmentRequest,
)
from app.schemas.mood import MoodSummaryOut
from app.services import assessment_service, assessment_templates, mood_service

router = APIRouter(prefix="/assessment", tags=["assessment"])


# ---- templates ---------------------------------------------------------------
# NOTE: static paths must precede the catch-all GET /{assessment_id} below.


@router.get("/templates", response_model=list[AssessmentTemplateOut])
async def list_templates(_: User = Depends(get_current_user)):
    """The selectable assessment templates (daily, weekly, burnout, …)."""
    return assessment_templates.catalog()


@router.get("/history", response_model=list[AssessmentHistoryItem])
async def history(
    limit: int = Query(30, ge=1, le=200),
    db: AsyncSession = Depends(get_db),
    user: User = Depends(get_current_user),
):
    """Completed assessments, most recent first."""
    return await assessment_service.completed_history(db, user, limit=limit)


@router.get("/result/{assessment_id}", response_model=MoodSummaryOut)
async def result(
    assessment_id: str,
    db: AsyncSession = Depends(get_db),
    user: User = Depends(get_current_user),
):
    """The computed mood profile for a completed assessment."""
    return await mood_service.summary_for_assessment(db, user, assessment_id)


# ---- adaptive flow -----------------------------------------------------------


@router.post("/start", response_model=NextQuestionOut)
async def start(
    payload: StartAssessmentRequest = StartAssessmentRequest(),
    template: str | None = Query(
        None, description="Template id (daily_checkin, weekly_reflection, burnout, …)"
    ),
    db: AsyncSession = Depends(get_db),
    user: User = Depends(get_current_user),
):
    """Begin a new adaptive assessment and get the first question."""
    return await assessment_service.start_assessment(
        db, user, payload.meta, template=template
    )


@router.post("/answer", response_model=AnswerAccepted)
async def answer(
    payload: AnswerRequest,
    assessment_id: str = Query(..., description="Active assessment id"),
    db: AsyncSession = Depends(get_db),
    user: User = Depends(get_current_user),
):
    """Submit an answer; receive the next adaptively-chosen question."""
    return await assessment_service.record_answer(db, user, assessment_id, payload)


@router.get("/next-question", response_model=NextQuestionOut)
async def next_question(
    assessment_id: str = Query(...),
    db: AsyncSession = Depends(get_db),
    user: User = Depends(get_current_user),
):
    """Re-fetch the current next question (idempotent)."""
    return await assessment_service.next_question(db, user, assessment_id)


@router.post("/complete", response_model=MoodSummaryOut)
async def complete(
    assessment_id: str = Query(...),
    db: AsyncSession = Depends(get_db),
    user: User = Depends(get_current_user),
):
    """Finalize the assessment and compute the mood profile."""
    return await mood_service.complete_assessment(db, user, assessment_id)


@router.get("/{assessment_id}", response_model=AssessmentSummary)
async def get_assessment(
    assessment_id: str,
    db: AsyncSession = Depends(get_db),
    user: User = Depends(get_current_user),
):
    return await assessment_service.get_owned_assessment(db, user, assessment_id)
