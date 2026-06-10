"""Windowed insight endpoints (camelCase, cached)."""
from __future__ import annotations

from fastapi import APIRouter, Depends
from sqlalchemy.ext.asyncio import AsyncSession

from app.api.deps import get_current_user
from app.database import get_db
from app.models import User
from app.schemas.insight_detail import InsightDetailOut
from app.schemas.insights import InsightOut
from app.schemas.wellness_score import WellnessScoreOut
from app.services import (
    insight_detail_service,
    insights_view_service,
    wellness_score_service,
)

router = APIRouter(prefix="/insights", tags=["insights"])


@router.get("/wellness-score", response_model=WellnessScoreOut)
async def wellness_score(
    db: AsyncSession = Depends(get_db),
    user: User = Depends(get_current_user),
):
    return await wellness_score_service.wellness_score(db, user)


@router.get("/detail/{detail_type}", response_model=InsightDetailOut)
async def insight_detail(
    detail_type: str,
    db: AsyncSession = Depends(get_db),
    user: User = Depends(get_current_user),
):
    # Only burnout is modelled today; other types fall back to it.
    return await insight_detail_service.burnout_detail(db, user)


@router.get("/daily", response_model=InsightOut)
async def daily(
    db: AsyncSession = Depends(get_db),
    user: User = Depends(get_current_user),
):
    return await insights_view_service.generate(db, user, "daily")


@router.get("/weekly", response_model=InsightOut)
async def weekly(
    db: AsyncSession = Depends(get_db),
    user: User = Depends(get_current_user),
):
    return await insights_view_service.generate(db, user, "weekly")


@router.get("/monthly", response_model=InsightOut)
async def monthly(
    db: AsyncSession = Depends(get_db),
    user: User = Depends(get_current_user),
):
    return await insights_view_service.generate(db, user, "monthly")
