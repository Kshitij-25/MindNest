"""Check-in streak bookkeeping (one ``streaks`` row per user)."""
from __future__ import annotations

from datetime import date, timedelta

from sqlalchemy import select

from app.core.utils import utcnow
from app.models import Streak, User


async def get_streak(db, user: User) -> Streak | None:
    res = await db.execute(select(Streak).where(Streak.user_id == user.id))
    return res.scalar_one_or_none()


async def record_checkin(db, user: User, *, on: date | None = None) -> Streak:
    """Advance the streak for a check-in on ``on`` (defaults to today).

    Same-day check-ins don't change the count; consecutive days increment it;
    a gap resets to 1. Does not commit — the caller owns the transaction.
    """
    today = on or utcnow().date()
    streak = await get_streak(db, user)
    if streak is None:
        streak = Streak(
            user_id=user.id,
            current=1,
            longest=1,
            last_checkin_date=today,
            goal=getattr(user, "streak_goal", 7) or 7,
        )
        db.add(streak)
        return streak

    last = streak.last_checkin_date
    if last == today:
        pass  # already counted today
    elif last is not None and last == today - timedelta(days=1):
        streak.current += 1
    else:
        streak.current = 1
    streak.longest = max(streak.longest, streak.current)
    streak.last_checkin_date = today
    streak.updated_at = utcnow()
    return streak
