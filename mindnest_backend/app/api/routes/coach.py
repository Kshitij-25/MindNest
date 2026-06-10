"""AI coach endpoints (camelCase)."""
from __future__ import annotations

from fastapi import APIRouter, Depends
from sqlalchemy.ext.asyncio import AsyncSession

from app.api.deps import get_current_user
from app.database import get_db
from app.models import User
from app.schemas.coach import (
    CoachChatOut,
    CoachChatRequest,
    CoachConversationOut,
    CoachMessageOut,
)
from app.services import coach_service

router = APIRouter(prefix="/coach", tags=["coach"])


@router.post("/chat", response_model=CoachChatOut)
async def chat(
    payload: CoachChatRequest,
    db: AsyncSession = Depends(get_db),
    user: User = Depends(get_current_user),
):
    """Send a message; receive a grounded, supportive reply."""
    return await coach_service.chat(db, user, payload.message, payload.conversation_id)


@router.get("/conversations", response_model=list[CoachConversationOut])
async def conversations(
    db: AsyncSession = Depends(get_db),
    user: User = Depends(get_current_user),
):
    return await coach_service.conversations(db, user)


@router.get("/history", response_model=list[CoachMessageOut])
async def history(
    conversation_id: str,
    db: AsyncSession = Depends(get_db),
    user: User = Depends(get_current_user),
):
    return await coach_service.history(db, user, conversation_id)
