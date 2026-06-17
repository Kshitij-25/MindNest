"""Direct messaging between a user and a professional.

A conversation is unique per (user, professional) pair. Ownership is enforced
per actor: a user only reaches conversations where they are ``user_id``; a
professional only where they are ``professional_id``.
"""
from __future__ import annotations

from fastapi import HTTPException, status
from sqlalchemy import select

from app.core.utils import utcnow
from app.models import Conversation, Message, SenderType
from app.services import professional_service


async def get_or_create(db, user, professional_id: str) -> Conversation:
    await professional_service.get(db, professional_id)  # 404 if unknown
    res = await db.execute(
        select(Conversation).where(
            Conversation.user_id == user.id,
            Conversation.professional_id == professional_id,
        )
    )
    conv = res.scalar_one_or_none()
    if conv is None:
        conv = Conversation(user_id=user.id, professional_id=professional_id)
        db.add(conv)
        await db.commit()
        await db.refresh(conv)
    return conv


async def list_for_user(db, user) -> list[Conversation]:
    res = await db.execute(
        select(Conversation)
        .where(Conversation.user_id == user.id)
        .order_by(Conversation.last_message_at.desc())
    )
    return list(res.scalars().all())


async def list_for_professional(db, pro) -> list[Conversation]:
    res = await db.execute(
        select(Conversation)
        .where(Conversation.professional_id == pro.id)
        .order_by(Conversation.last_message_at.desc())
    )
    return list(res.scalars().all())


async def _conversation_for_actor(
    db, conversation_id: str, actor_type: str, actor_id: str
) -> Conversation:
    res = await db.execute(
        select(Conversation).where(Conversation.id == conversation_id)
    )
    conv = res.scalar_one_or_none()
    if conv is None:
        raise HTTPException(status.HTTP_404_NOT_FOUND, "Conversation not found")
    owner_id = conv.user_id if actor_type == SenderType.USER else conv.professional_id
    if owner_id != actor_id:
        raise HTTPException(status.HTTP_404_NOT_FOUND, "Conversation not found")
    return conv


async def send_message(
    db,
    conversation_id: str,
    actor_type: str,
    actor_id: str,
    payload,
) -> Message:
    conv = await _conversation_for_actor(db, conversation_id, actor_type, actor_id)
    msg = Message(
        conversation_id=conv.id,
        sender_type=actor_type,
        sender_id=actor_id,
        body=payload.body,
        attachments=payload.attachments or [],
    )
    db.add(msg)
    conv.last_message_at = utcnow()
    await db.commit()
    await db.refresh(msg)
    return msg


async def list_messages(
    db, conversation_id: str, actor_type: str, actor_id: str
) -> list[Message]:
    conv = await _conversation_for_actor(db, conversation_id, actor_type, actor_id)
    res = await db.execute(
        select(Message)
        .where(Message.conversation_id == conv.id)
        .order_by(Message.created_at)
    )
    messages = list(res.scalars().all())
    # Mark messages from the *other* party as read.
    changed = False
    for m in messages:
        if m.sender_type != actor_type and not m.read:
            m.read = True
            changed = True
    if changed:
        await db.commit()
    return messages


async def _unread_and_last(db, conversation_id: str, viewer_type: str) -> tuple[int, str | None]:
    res = await db.execute(
        select(Message)
        .where(Message.conversation_id == conversation_id)
        .order_by(Message.created_at)
    )
    msgs = list(res.scalars().all())
    unread = sum(1 for m in msgs if m.sender_type != viewer_type and not m.read)
    last = msgs[-1].body if msgs else None
    return unread, last


async def conversation_out(db, conv: Conversation, viewer_type: str) -> dict:
    unread, last = await _unread_and_last(db, conv.id, viewer_type)
    return {
        "id": conv.id,
        "user_id": conv.user_id,
        "professional_id": conv.professional_id,
        "created_at": conv.created_at,
        "last_message_at": conv.last_message_at,
        "unread_count": unread,
        "last_message": last,
    }


def message_out(m: Message) -> dict:
    return {
        "id": m.id,
        "conversation_id": m.conversation_id,
        "sender_type": m.sender_type,
        "sender_id": m.sender_id,
        "body": m.body,
        "attachments": m.attachments or [],
        "read": m.read,
        "created_at": m.created_at,
    }
