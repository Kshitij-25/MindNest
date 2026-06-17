"""Availability engine: weekly rules + exceptions → concrete bookable slots.

Slots are generated lazily (on first listing) and on demand, from the
recurring :class:`AvailabilityRule` windows within a rolling horizon, skipping
:class:`AvailabilityException` dates and any already-generated start times.
Times are naive UTC (matching ``core.utils.utcnow``).
"""
from __future__ import annotations

from datetime import datetime, timedelta

from fastapi import HTTPException, status
from sqlalchemy import select

from app.core.utils import utcnow
from app.models import (
    AvailabilityException,
    AvailabilityRule,
    AvailabilitySlot,
)

HORIZON_DAYS = 21


# ---- rules -------------------------------------------------------------------


async def add_rule(db, pro, payload) -> AvailabilityRule:
    if payload.end_minute <= payload.start_minute:
        raise HTTPException(
            status.HTTP_400_BAD_REQUEST, "endMinute must be after startMinute"
        )
    rule = AvailabilityRule(
        professional_id=pro.id,
        weekday=payload.weekday,
        start_minute=payload.start_minute,
        end_minute=payload.end_minute,
        slot_minutes=payload.slot_minutes,
    )
    db.add(rule)
    await db.commit()
    await db.refresh(rule)
    return rule


async def list_rules(db, professional_id: str) -> list[AvailabilityRule]:
    res = await db.execute(
        select(AvailabilityRule)
        .where(AvailabilityRule.professional_id == professional_id)
        .order_by(AvailabilityRule.weekday, AvailabilityRule.start_minute)
    )
    return list(res.scalars().all())


async def delete_rule(db, pro, rule_id: str) -> None:
    res = await db.execute(
        select(AvailabilityRule).where(AvailabilityRule.id == rule_id)
    )
    rule = res.scalar_one_or_none()
    if rule is None or rule.professional_id != pro.id:
        raise HTTPException(status.HTTP_404_NOT_FOUND, "Rule not found")
    await db.delete(rule)
    await db.commit()


# ---- exceptions --------------------------------------------------------------


async def add_exception(db, pro, payload) -> AvailabilityException:
    exc = AvailabilityException(
        professional_id=pro.id,
        date=payload.date,
        kind=payload.kind,
        reason=payload.reason or "",
    )
    db.add(exc)
    await db.commit()
    await db.refresh(exc)
    return exc


async def list_exceptions(db, professional_id: str) -> list[AvailabilityException]:
    res = await db.execute(
        select(AvailabilityException)
        .where(AvailabilityException.professional_id == professional_id)
        .order_by(AvailabilityException.date)
    )
    return list(res.scalars().all())


async def delete_exception(db, pro, exception_id: str) -> None:
    res = await db.execute(
        select(AvailabilityException).where(
            AvailabilityException.id == exception_id
        )
    )
    exc = res.scalar_one_or_none()
    if exc is None or exc.professional_id != pro.id:
        raise HTTPException(status.HTTP_404_NOT_FOUND, "Exception not found")
    await db.delete(exc)
    await db.commit()


# ---- slot generation ---------------------------------------------------------


async def generate_slots(
    db, professional_id: str, *, horizon_days: int = HORIZON_DAYS
) -> int:
    """Materialize future slots from the rules. Idempotent on start_time."""
    rules = await list_rules(db, professional_id)
    if not rules:
        return 0

    now = utcnow()
    start_day = now.date()

    exc_res = await db.execute(
        select(AvailabilityException.date).where(
            AvailabilityException.professional_id == professional_id,
            AvailabilityException.date >= start_day,
        )
    )
    blocked = {d for (d,) in exc_res.all()}

    existing_res = await db.execute(
        select(AvailabilitySlot.start_time).where(
            AvailabilitySlot.professional_id == professional_id,
            AvailabilitySlot.start_time >= now,
        )
    )
    existing = {s for (s,) in existing_res.all()}

    rules_by_weekday: dict[int, list[AvailabilityRule]] = {}
    for r in rules:
        rules_by_weekday.setdefault(r.weekday, []).append(r)

    created = 0
    for offset in range(horizon_days + 1):
        day = start_day + timedelta(days=offset)
        if day in blocked:
            continue
        midnight = datetime(day.year, day.month, day.day)
        for rule in rules_by_weekday.get(day.weekday(), []):
            minute = rule.start_minute
            while minute + rule.slot_minutes <= rule.end_minute:
                start_dt = midnight + timedelta(minutes=minute)
                minute += rule.slot_minutes
                if start_dt <= now or start_dt in existing:
                    continue
                db.add(
                    AvailabilitySlot(
                        professional_id=professional_id,
                        start_time=start_dt,
                        end_time=start_dt + timedelta(minutes=rule.slot_minutes),
                        available=True,
                    )
                )
                existing.add(start_dt)
                created += 1

    if created:
        await db.commit()
    return created


async def list_available(
    db,
    professional_id: str,
    *,
    horizon_days: int = HORIZON_DAYS,
    ensure: bool = True,
) -> list[AvailabilitySlot]:
    now = utcnow()
    if ensure:
        probe = await db.execute(
            select(AvailabilitySlot.id).where(
                AvailabilitySlot.professional_id == professional_id,
                AvailabilitySlot.start_time >= now,
                AvailabilitySlot.available.is_(True),
            ).limit(1)
        )
        if probe.scalar_one_or_none() is None:
            await generate_slots(db, professional_id, horizon_days=horizon_days)

    res = await db.execute(
        select(AvailabilitySlot)
        .where(
            AvailabilitySlot.professional_id == professional_id,
            AvailabilitySlot.start_time >= now,
            AvailabilitySlot.available.is_(True),
        )
        .order_by(AvailabilitySlot.start_time)
    )
    return list(res.scalars().all())


async def next_available_at(db, professional_id: str) -> datetime | None:
    slots = await list_available(db, professional_id, ensure=False)
    return slots[0].start_time if slots else None


async def get_slot(db, slot_id: str) -> AvailabilitySlot | None:
    res = await db.execute(
        select(AvailabilitySlot).where(AvailabilitySlot.id == slot_id)
    )
    return res.scalar_one_or_none()


# ---- serialization -----------------------------------------------------------


def rule_out(r: AvailabilityRule) -> dict:
    return {
        "id": r.id,
        "professional_id": r.professional_id,
        "weekday": r.weekday,
        "start_minute": r.start_minute,
        "end_minute": r.end_minute,
        "slot_minutes": r.slot_minutes,
        "created_at": r.created_at,
    }


def exception_out(e: AvailabilityException) -> dict:
    return {
        "id": e.id,
        "professional_id": e.professional_id,
        "date": e.date,
        "kind": e.kind,
        "reason": e.reason,
        "created_at": e.created_at,
    }


def slot_out(s: AvailabilitySlot) -> dict:
    return {
        "id": s.id,
        "professional_id": s.professional_id,
        "start_time": s.start_time,
        "end_time": s.end_time,
        "available": s.available,
    }
