"""AI coach orchestration + conversation persistence.

Respects the ``enable_coach`` feature flag. Each assistant turn stores the
``context_snapshot`` (mood + concerns + recommendations + retrieved memories)
that grounded it.
"""
from __future__ import annotations

from fastapi import HTTPException, status
from sqlalchemy import select

from app.ai.coaching import coach, context
from app.core.feature_flags import flag_enabled
from app.core.utils import utcnow
from app.models import CoachConversation, CoachMessage, User


def _title_from(message: str) -> str:
    t = (message or "").strip().splitlines()[0] if message.strip() else "New conversation"
    return (t[:57] + "…") if len(t) > 58 else t


async def _owned_conversation(db, user: User, conversation_id: str) -> CoachConversation:
    res = await db.execute(
        select(CoachConversation).where(CoachConversation.id == conversation_id)
    )
    conv = res.scalar_one_or_none()
    if conv is None or conv.user_id != user.id:
        raise HTTPException(status.HTTP_404_NOT_FOUND, "Conversation not found")
    return conv


def _msg_out(m: CoachMessage) -> dict:
    return {
        "id": m.id,
        "conversation_id": m.conversation_id,
        "role": m.role,
        "content": m.content,
        "created_at": m.created_at,
    }


async def chat(db, user: User, message: str, conversation_id: str | None = None) -> dict:
    if not flag_enabled(user.settings, "enable_coach"):
        raise HTTPException(
            status.HTTP_403_FORBIDDEN,
            "The AI coach is turned off in your settings.",
        )

    if conversation_id:
        conv = await _owned_conversation(db, user, conversation_id)
    else:
        conv = CoachConversation(user_id=user.id, title=_title_from(message))
        db.add(conv)
        await db.flush()

    ctx = await context.build(db, user, message)

    db.add(CoachMessage(
        conversation_id=conv.id, user_id=user.id, role="user", content=message,
    ))
    reply, model = await coach.respond(message, ctx)
    assistant = CoachMessage(
        conversation_id=conv.id, user_id=user.id, role="assistant",
        content=reply, context_snapshot=ctx,
    )
    db.add(assistant)
    conv.updated_at = utcnow()
    await db.commit()
    await db.refresh(assistant)

    return {
        "conversation_id": conv.id,
        "reply": reply,
        "model": model,
        "context": ctx,
        "created_at": assistant.created_at,
    }


async def history(db, user: User, conversation_id: str) -> list[dict]:
    conv = await _owned_conversation(db, user, conversation_id)
    res = await db.execute(
        select(CoachMessage)
        .where(CoachMessage.conversation_id == conv.id)
        .order_by(CoachMessage.created_at)
    )
    return [_msg_out(m) for m in res.scalars().all()]


async def conversations(db, user: User) -> list[dict]:
    res = await db.execute(
        select(CoachConversation)
        .where(CoachConversation.user_id == user.id)
        .order_by(CoachConversation.updated_at.desc())
    )
    return [
        {
            "id": c.id,
            "title": c.title,
            "created_at": c.created_at,
            "updated_at": c.updated_at,
        }
        for c in res.scalars().all()
    ]
