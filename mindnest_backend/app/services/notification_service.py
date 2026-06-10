"""In-app notifications.

``create`` adds a row without committing (callers own the transaction so a
notification can be written atomically with the thing it announces, e.g. a new
weekly report). Read/mutation helpers commit themselves.
"""
from __future__ import annotations

from sqlalchemy import select, update

from app.core.feature_flags import flag_enabled
from app.core.time_format import relative_time
from app.models import Notification, User


def to_out(n: Notification) -> dict:
    return {
        "id": n.id,
        "type": n.type,
        "title": n.title,
        "body": n.body or "",
        "unread": n.unread,
        "ref_id": n.ref_id,
        "relative_time": relative_time(n.created_at),
        "created_at": n.created_at,
    }


async def create(db, *, user: User, type: str, title: str, body: str = "",
                 ref_id: str | None = None) -> Notification | None:
    """Add a notification (no commit). Respects the ``notifications`` flag."""
    if not flag_enabled(user.settings, "notifications"):
        return None
    n = Notification(user_id=user.id, type=type, title=title, body=body, ref_id=ref_id)
    db.add(n)
    return n


async def list_notifications(db, user: User, *, unread_only: bool = False,
                             limit: int = 50) -> list[dict]:
    stmt = select(Notification).where(Notification.user_id == user.id)
    if unread_only:
        stmt = stmt.where(Notification.unread.is_(True))
    stmt = stmt.order_by(Notification.created_at.desc()).limit(limit)
    res = await db.execute(stmt)
    return [to_out(n) for n in res.scalars().all()]


async def unread_count(db, user: User) -> int:
    from sqlalchemy import func
    res = await db.execute(
        select(func.count()).select_from(Notification).where(
            Notification.user_id == user.id, Notification.unread.is_(True)
        )
    )
    return int(res.scalar() or 0)


async def mark_read(db, user: User, notification_id: str) -> dict:
    from fastapi import HTTPException, status
    res = await db.execute(
        select(Notification).where(Notification.id == notification_id)
    )
    n = res.scalar_one_or_none()
    if n is None or n.user_id != user.id:
        raise HTTPException(status.HTTP_404_NOT_FOUND, "Notification not found")
    n.unread = False
    await db.commit()
    await db.refresh(n)
    return to_out(n)


async def mark_all_read(db, user: User) -> dict:
    await db.execute(
        update(Notification)
        .where(Notification.user_id == user.id, Notification.unread.is_(True))
        .values(unread=False)
    )
    await db.commit()
    return {"ok": True}
