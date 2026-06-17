"""Messaging endpoints (MVP 2, Phase B).

Users and professionals each have their own conversation list + message views;
the service enforces that each side only reaches its own conversations.
"""
from __future__ import annotations

from fastapi import APIRouter, Depends, status
from sqlalchemy.ext.asyncio import AsyncSession

from app.api.deps import get_current_professional, get_current_user
from app.database import get_db
from app.models import Professional, SenderType, User
from app.schemas.messaging import (
    ConversationOut,
    ConversationStart,
    MessageCreate,
    MessageOut,
)
from app.services import messaging_service

router = APIRouter(prefix="/messaging", tags=["Messaging"])


# ---- user side ---------------------------------------------------------------


@router.post(
    "/conversations", response_model=ConversationOut, status_code=status.HTTP_201_CREATED
)
async def start_conversation(
    payload: ConversationStart,
    db: AsyncSession = Depends(get_db),
    user: User = Depends(get_current_user),
):
    conv = await messaging_service.get_or_create(db, user, payload.professional_id)
    return await messaging_service.conversation_out(db, conv, SenderType.USER)


@router.get("/conversations", response_model=list[ConversationOut])
async def my_conversations(
    db: AsyncSession = Depends(get_db),
    user: User = Depends(get_current_user),
):
    convs = await messaging_service.list_for_user(db, user)
    return [
        await messaging_service.conversation_out(db, c, SenderType.USER) for c in convs
    ]


@router.get("/conversations/{conversation_id}/messages", response_model=list[MessageOut])
async def user_messages(
    conversation_id: str,
    db: AsyncSession = Depends(get_db),
    user: User = Depends(get_current_user),
):
    msgs = await messaging_service.list_messages(
        db, conversation_id, SenderType.USER, user.id
    )
    return [messaging_service.message_out(m) for m in msgs]


@router.post(
    "/conversations/{conversation_id}/messages",
    response_model=MessageOut,
    status_code=status.HTTP_201_CREATED,
)
async def user_send(
    conversation_id: str,
    payload: MessageCreate,
    db: AsyncSession = Depends(get_db),
    user: User = Depends(get_current_user),
):
    msg = await messaging_service.send_message(
        db, conversation_id, SenderType.USER, user.id, payload
    )
    return messaging_service.message_out(msg)


# ---- professional side -------------------------------------------------------


@router.get("/pro/conversations", response_model=list[ConversationOut])
async def pro_conversations(
    db: AsyncSession = Depends(get_db),
    pro: Professional = Depends(get_current_professional),
):
    convs = await messaging_service.list_for_professional(db, pro)
    return [
        await messaging_service.conversation_out(db, c, SenderType.PROFESSIONAL)
        for c in convs
    ]


@router.get(
    "/pro/conversations/{conversation_id}/messages", response_model=list[MessageOut]
)
async def pro_messages(
    conversation_id: str,
    db: AsyncSession = Depends(get_db),
    pro: Professional = Depends(get_current_professional),
):
    msgs = await messaging_service.list_messages(
        db, conversation_id, SenderType.PROFESSIONAL, pro.id
    )
    return [messaging_service.message_out(m) for m in msgs]


@router.post(
    "/pro/conversations/{conversation_id}/messages",
    response_model=MessageOut,
    status_code=status.HTTP_201_CREATED,
)
async def pro_send(
    conversation_id: str,
    payload: MessageCreate,
    db: AsyncSession = Depends(get_db),
    pro: Professional = Depends(get_current_professional),
):
    msg = await messaging_service.send_message(
        db, conversation_id, SenderType.PROFESSIONAL, pro.id, payload
    )
    return messaging_service.message_out(msg)
