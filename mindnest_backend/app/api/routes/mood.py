"""Mood check-in + read endpoints (camelCase)."""
from __future__ import annotations

from fastapi import APIRouter, Depends, Query
from sqlalchemy.ext.asyncio import AsyncSession

from app.api.deps import get_current_user
from app.database import get_db
from app.models import User
from app.schemas.mood_tracking import (
    CheckinOut,
    CheckinRequest,
    FactorOut,
    MoodCalendarOut,
    MoodHistoryOut,
    MoodInsightsOut,
    MoodTrendsOut,
)
from app.services import mood_checkin_service, mood_factors, mood_view_service

router = APIRouter(prefix="/mood", tags=["mood"])


@router.get("/factors", response_model=list[FactorOut])
async def factors(_: User = Depends(get_current_user)):
    """The selectable check-in factors (client's source of truth)."""
    return mood_factors.catalog()


@router.post("/checkin", response_model=CheckinOut)
async def checkin(
    payload: CheckinRequest,
    db: AsyncSession = Depends(get_db),
    user: User = Depends(get_current_user),
):
    """Record a mood check-in (drives the engine, streak and recommendations)."""
    return await mood_checkin_service.checkin(db, user, payload)


@router.get("/history", response_model=MoodHistoryOut)
async def history(
    days: int = Query(28, ge=7, le=120),
    db: AsyncSession = Depends(get_db),
    user: User = Depends(get_current_user),
):
    return await mood_view_service.history(db, user, days=days)


@router.get("/calendar", response_model=MoodCalendarOut)
async def calendar(
    year: int | None = Query(None, ge=2000, le=2100),
    month: int | None = Query(None, ge=1, le=12),
    db: AsyncSession = Depends(get_db),
    user: User = Depends(get_current_user),
):
    return await mood_view_service.calendar(db, user, year=year, month=month)


@router.get("/trends", response_model=MoodTrendsOut)
async def trends(
    days: int = Query(30, ge=1, le=365),
    db: AsyncSession = Depends(get_db),
    user: User = Depends(get_current_user),
):
    return await mood_view_service.trends(db, user, days=days)


@router.get("/insights", response_model=MoodInsightsOut)
async def insights(
    days: int = Query(7, ge=1, le=90),
    db: AsyncSession = Depends(get_db),
    user: User = Depends(get_current_user),
):
    return await mood_view_service.insights(db, user, days=days)
