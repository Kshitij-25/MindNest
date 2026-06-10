"""Personalised recommendations + the feedback loop (camelCase)."""
from __future__ import annotations

from fastapi import APIRouter, Depends
from sqlalchemy.ext.asyncio import AsyncSession

from app.api.deps import get_current_user
from app.database import get_db
from app.models import User
from app.schemas.recommendation import (
    FeedbackOut,
    FeedbackRequest,
    RecommendationOut,
)
from app.services import recommendation_service

router = APIRouter(prefix="/recommendations", tags=["recommendations"])


@router.get("", response_model=list[RecommendationOut])
async def list_recommendations(
    db: AsyncSession = Depends(get_db),
    user: User = Depends(get_current_user),
):
    """Ranked, active recommendations (auto-generated on first read)."""
    return await recommendation_service.list_active(db, user)


@router.post("/regenerate", response_model=list[RecommendationOut])
async def regenerate(
    db: AsyncSession = Depends(get_db),
    user: User = Depends(get_current_user),
):
    """Force a refresh from the latest emotional state."""
    return await recommendation_service.regenerate(db, user)


@router.post("/{rec_id}/feedback", response_model=FeedbackOut)
async def submit_feedback(
    rec_id: str,
    payload: FeedbackRequest,
    db: AsyncSession = Depends(get_db),
    user: User = Depends(get_current_user),
):
    """Record feedback (accepted|dismissed|completed|helpful|not_helpful)."""
    rec = await recommendation_service.feedback(db, user, rec_id, payload.action)
    return {
        "id": rec.id,
        "recommendation_id": rec.id,
        "action": payload.action,
        "status": rec.status,
    }
