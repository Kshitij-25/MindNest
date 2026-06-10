"""Daily / weekly / monthly insight windows (camelCase, cached).

Thin windows over the deterministic ``insights_service`` engine, materialised
into the ``insights`` table so dashboard reads are snappy and repeated reads in
a period are stable. Payloads are stored JSON-safe (ISO timestamps).
"""
from __future__ import annotations

from sqlalchemy import select

from app.core.time_format import iso_week_key
from app.core.utils import utcnow
from app.models import Insight, User
from app.services import insights_service

SCOPE_DAYS = {"daily": 1, "weekly": 7, "monthly": 30}


def _period_key(scope: str, now) -> str:
    if scope == "daily":
        return now.date().isoformat()
    if scope == "weekly":
        return iso_week_key(now)
    return f"{now.year:04d}-{now.month:02d}"


async def generate(db, user: User, scope: str) -> dict:
    """Compute the window fresh and upsert the cache row; returns the payload."""
    days = SCOPE_DAYS.get(scope, 7)
    now = utcnow()
    pk = _period_key(scope, now)

    data = await insights_service.insights(db, user, days=days)
    bp = data.get("burnout_progression", {})
    payload = {
        "scope": scope,
        "period_key": pk,
        "headline": data["headline"],
        "insights": data["insights"],
        "samples": data["samples"],
        "burnout": {
            "first": bp.get("first", 0.0),
            "last": bp.get("last", 0.0),
            "delta": bp.get("delta", 0.0),
            "direction": bp.get("direction", "stable"),
        },
        "generated_at": now.isoformat(),
    }

    res = await db.execute(
        select(Insight).where(
            Insight.user_id == user.id,
            Insight.scope == scope,
            Insight.period_key == pk,
        )
    )
    row = res.scalar_one_or_none()
    if row is None:
        row = Insight(user_id=user.id, scope=scope, period_key=pk)
        db.add(row)
    row.payload = payload
    row.generated_at = now
    await db.commit()
    return payload


async def latest_cached(db, user: User) -> dict | None:
    res = await db.execute(
        select(Insight)
        .where(Insight.user_id == user.id)
        .order_by(Insight.generated_at.desc())
        .limit(1)
    )
    row = res.scalar_one_or_none()
    return row.payload if row else None
