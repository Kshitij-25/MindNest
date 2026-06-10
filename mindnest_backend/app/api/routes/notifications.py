"""Notification endpoints (camelCase)."""
from __future__ import annotations

from fastapi import APIRouter, Depends, Query
from sqlalchemy.ext.asyncio import AsyncSession

from app.api.deps import get_current_user
from app.database import get_db
from app.models import User
from app.schemas.notification import MarkAllReadOut, NotificationOut
from app.services import notification_service

router = APIRouter(prefix="/notifications", tags=["notifications"])


@router.get("", response_model=list[NotificationOut])
async def list_notifications(
    unread_only: bool = Query(False),
    limit: int = Query(50, ge=1, le=200),
    db: AsyncSession = Depends(get_db),
    user: User = Depends(get_current_user),
):
    return await notification_service.list_notifications(
        db, user, unread_only=unread_only, limit=limit
    )


# Static path before /{notification_id}.
@router.patch("/mark-all-read", response_model=MarkAllReadOut)
async def mark_all_read(
    db: AsyncSession = Depends(get_db),
    user: User = Depends(get_current_user),
):
    return await notification_service.mark_all_read(db, user)


@router.patch("/{notification_id}", response_model=NotificationOut)
async def mark_read(
    notification_id: str,
    db: AsyncSession = Depends(get_db),
    user: User = Depends(get_current_user),
):
    return await notification_service.mark_read(db, user, notification_id)
