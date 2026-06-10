"""Mood profile, history, trends and insights endpoints."""
from __future__ import annotations

from fastapi import APIRouter, Depends, Query
from sqlalchemy.ext.asyncio import AsyncSession

from app.api.deps import get_current_user
from app.database import get_db
from app.models import User
from app.schemas.mood import (
    HistoryItem,
    InsightsOut,
    MoodSummaryOut,
    TrendsOut,
)
from app.services import insights_service, mood_service

router = APIRouter(prefix="/profile", tags=["profile"])


@router.get("/mood-summary", response_model=MoodSummaryOut)
async def mood_summary(
    db: AsyncSession = Depends(get_db),
    user: User = Depends(get_current_user),
):
    """The most recent mood profile."""
    profile = await mood_service.latest_profile(db, user)
    return mood_service.profile_to_summary(profile)


@router.get("/history", response_model=list[HistoryItem])
async def history(
    limit: int = Query(30, ge=1, le=200),
    db: AsyncSession = Depends(get_db),
    user: User = Depends(get_current_user),
):
    profiles = await mood_service.history(db, user, limit=limit)
    return [
        {
            "assessment_id": p.assessment_id,
            "created_at": p.created_at,
            "overall_mood": p.overall_mood,
            "valence": p.valence,
            "confidence": p.confidence,
            "top_emotions": p.top_emotions or [],
        }
        for p in profiles
    ]


@router.get("/trends", response_model=TrendsOut)
async def trends(
    days: int = Query(30, ge=1, le=365),
    db: AsyncSession = Depends(get_db),
    user: User = Depends(get_current_user),
):
    return await insights_service.trends(db, user, days=days)


@router.get("/insights", response_model=InsightsOut)
async def insights(
    days: int = Query(7, ge=1, le=90),
    db: AsyncSession = Depends(get_db),
    user: User = Depends(get_current_user),
):
    return await insights_service.insights(db, user, days=days)
