"""Analytics endpoints: emotional timeline + pattern detector (camelCase)."""
from __future__ import annotations

from fastapi import APIRouter, Depends, Query
from sqlalchemy.ext.asyncio import AsyncSession

from app.api.deps import get_current_user
from app.database import get_db
from app.models import User
from app.schemas.analytics import EmotionalTimelineOut, PatternsOut
from app.services import analytics_service

router = APIRouter(prefix="/analytics", tags=["analytics"])


@router.get("/emotional-timeline", response_model=EmotionalTimelineOut)
async def emotional_timeline(
    days: int = Query(30, ge=7, le=180),
    db: AsyncSession = Depends(get_db),
    user: User = Depends(get_current_user),
):
    """Explain *why* emotion changed: drift attributed to recurring drivers."""
    return await analytics_service.emotional_timeline_view(db, user, days=days)


@router.get("/patterns", response_model=PatternsOut)
async def patterns(
    days: int = Query(30, ge=7, le=180),
    db: AsyncSession = Depends(get_db),
    user: User = Depends(get_current_user),
):
    """Recurring themes, triggers and behaviour patterns as cards."""
    return await analytics_service.patterns_view(db, user, days=days)
