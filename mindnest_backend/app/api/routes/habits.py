"""Habit endpoints (camelCase)."""
from __future__ import annotations

from fastapi import APIRouter, Depends, Query, Response, status
from sqlalchemy.ext.asyncio import AsyncSession

from app.api.deps import get_current_user
from app.database import get_db
from app.models import User
from app.schemas.habit import (
    HabitAnalyticsOut,
    HabitCreate,
    HabitLogOut,
    HabitLogRequest,
    HabitOut,
    HabitUpdate,
)
from app.services import habit_service

router = APIRouter(prefix="/habits", tags=["habits"])


@router.get("", response_model=list[HabitOut])
async def list_habits(
    include_inactive: bool = Query(False),
    db: AsyncSession = Depends(get_db),
    user: User = Depends(get_current_user),
):
    return await habit_service.list_habits(db, user, include_inactive=include_inactive)


@router.post("", response_model=HabitOut, status_code=status.HTTP_201_CREATED)
async def create_habit(
    payload: HabitCreate,
    db: AsyncSession = Depends(get_db),
    user: User = Depends(get_current_user),
):
    return await habit_service.create(db, user, payload)


@router.patch("/{habit_id}", response_model=HabitOut)
async def update_habit(
    habit_id: str,
    payload: HabitUpdate,
    db: AsyncSession = Depends(get_db),
    user: User = Depends(get_current_user),
):
    return await habit_service.update(db, user, habit_id, payload)


@router.delete("/{habit_id}", status_code=status.HTTP_204_NO_CONTENT)
async def delete_habit(
    habit_id: str,
    db: AsyncSession = Depends(get_db),
    user: User = Depends(get_current_user),
):
    await habit_service.delete(db, user, habit_id)
    return Response(status_code=status.HTTP_204_NO_CONTENT)


@router.post("/{habit_id}/log", response_model=HabitLogOut)
async def log_habit(
    habit_id: str,
    payload: HabitLogRequest,
    db: AsyncSession = Depends(get_db),
    user: User = Depends(get_current_user),
):
    """Mark a habit done for a day (idempotent per day)."""
    return await habit_service.log(db, user, habit_id, payload)


@router.get("/{habit_id}/logs", response_model=list[HabitLogOut])
async def habit_logs(
    habit_id: str,
    days: int = Query(30, ge=1, le=365),
    db: AsyncSession = Depends(get_db),
    user: User = Depends(get_current_user),
):
    return await habit_service.logs(db, user, habit_id, days=days)


@router.get("/{habit_id}/analytics", response_model=HabitAnalyticsOut)
async def habit_analytics(
    habit_id: str,
    db: AsyncSession = Depends(get_db),
    user: User = Depends(get_current_user),
):
    return await habit_service.analytics(db, user, habit_id)
