"""Weekly wellness report endpoints (camelCase)."""
from __future__ import annotations

from fastapi import APIRouter, Depends, Query
from sqlalchemy.ext.asyncio import AsyncSession

from app.api.deps import get_current_user
from app.database import get_db
from app.models import User
from app.schemas.report import WeeklyReportOut
from app.services import report_service

router = APIRouter(prefix="/reports", tags=["reports"])


# Static path must precede /weekly/{period_key}.
@router.get("/weekly/history", response_model=list[WeeklyReportOut])
async def weekly_history(
    limit: int = Query(12, ge=1, le=52),
    db: AsyncSession = Depends(get_db),
    user: User = Depends(get_current_user),
):
    return await report_service.history(db, user, limit=limit)


@router.get("/weekly", response_model=WeeklyReportOut)
async def weekly_current(
    refresh: bool = Query(False, description="Force regeneration of the current week"),
    db: AsyncSession = Depends(get_db),
    user: User = Depends(get_current_user),
):
    return await report_service.weekly(db, user, refresh=refresh)


@router.get("/weekly/{period_key}", response_model=WeeklyReportOut)
async def weekly_for_period(
    period_key: str,
    db: AsyncSession = Depends(get_db),
    user: User = Depends(get_current_user),
):
    return await report_service.weekly(db, user, period_key)
