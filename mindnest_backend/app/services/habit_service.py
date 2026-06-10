"""Habits (P0): CRUD, idempotent per-day logging and analytics.

Analytics covers completion rate, current/longest habit streak (cadence-aware)
and a *dimension correlation* — how the user's mood (or a target dimension)
differs on days the habit was done vs. days it wasn't, from ``mood_entries`` /
``EmotionalHistory``.
"""
from __future__ import annotations

from datetime import date, datetime, timedelta

from fastapi import HTTPException, status
from sqlalchemy import select

from app.core.dimensions import DIMENSION_LABELS
from app.core.utils import utcnow
from app.models import EmotionalHistory, Habit, HabitLog, MoodEntry, User

_WINDOW_DAYS = 30


# ---- serialization -----------------------------------------------------------


def _habit_out(h: Habit, *, done_today: bool = False) -> dict:
    return {
        "id": h.id,
        "name": h.name,
        "kind": h.kind,
        "cadence": h.cadence,
        "target_dimension": h.target_dimension,
        "active": h.active,
        "created_at": h.created_at,
        "done_today": done_today,
    }


# ---- reads -------------------------------------------------------------------


async def _owned(db, user: User, habit_id: str) -> Habit:
    res = await db.execute(select(Habit).where(Habit.id == habit_id))
    h = res.scalar_one_or_none()
    if h is None or h.user_id != user.id:
        raise HTTPException(status.HTTP_404_NOT_FOUND, "Habit not found")
    return h


async def list_habits(db, user: User, *, include_inactive: bool = False) -> list[dict]:
    stmt = select(Habit).where(Habit.user_id == user.id)
    if not include_inactive:
        stmt = stmt.where(Habit.active.is_(True))
    stmt = stmt.order_by(Habit.created_at)
    res = await db.execute(stmt)
    habits = list(res.scalars().all())
    if not habits:
        return []

    today = utcnow().date()
    done_res = await db.execute(
        select(HabitLog.habit_id).where(
            HabitLog.user_id == user.id,
            HabitLog.date == today,
            HabitLog.done.is_(True),
        )
    )
    done_today = {row[0] for row in done_res.all()}
    return [_habit_out(h, done_today=h.id in done_today) for h in habits]


# ---- writes ------------------------------------------------------------------


async def create(db, user: User, payload) -> dict:
    habit = Habit(
        user_id=user.id,
        name=payload.name,
        kind=payload.kind,
        cadence=payload.cadence,
        target_dimension=payload.target_dimension,
    )
    db.add(habit)
    await db.commit()
    await db.refresh(habit)
    return _habit_out(habit)


async def update(db, user: User, habit_id: str, payload) -> dict:
    h = await _owned(db, user, habit_id)
    fields = payload.model_dump(exclude_unset=True, by_alias=False)
    for key in ("name", "kind", "cadence", "target_dimension", "active"):
        if key in fields and fields[key] is not None:
            setattr(h, key, fields[key])
    await db.commit()
    await db.refresh(h)
    return _habit_out(h)


async def delete(db, user: User, habit_id: str) -> None:
    h = await _owned(db, user, habit_id)
    await db.delete(h)
    await db.commit()


async def log(db, user: User, habit_id: str, payload) -> dict:
    """Idempotent per-day log: a second log for the same day updates it."""
    h = await _owned(db, user, habit_id)
    on = payload.date or utcnow().date()
    res = await db.execute(
        select(HabitLog).where(HabitLog.habit_id == h.id, HabitLog.date == on)
    )
    entry = res.scalar_one_or_none()
    if entry is None:
        entry = HabitLog(habit_id=h.id, user_id=user.id, date=on)
        db.add(entry)
    entry.done = payload.done if payload.done is not None else True
    entry.note = payload.note
    await db.commit()
    await db.refresh(entry)
    return {
        "id": entry.id,
        "habit_id": entry.habit_id,
        "date": entry.date,
        "done": entry.done,
        "note": entry.note,
        "created_at": entry.created_at,
    }


async def logs(db, user: User, habit_id: str, *, days: int = 30) -> list[dict]:
    h = await _owned(db, user, habit_id)
    cutoff = utcnow().date() - timedelta(days=days)
    res = await db.execute(
        select(HabitLog)
        .where(HabitLog.habit_id == h.id, HabitLog.date >= cutoff)
        .order_by(HabitLog.date.desc())
    )
    return [
        {
            "id": e.id, "habit_id": e.habit_id, "date": e.date,
            "done": e.done, "note": e.note, "created_at": e.created_at,
        }
        for e in res.scalars().all()
    ]


# ---- analytics ---------------------------------------------------------------


def _period_index(d: date, cadence: str) -> int:
    o = d.toordinal()
    return o if cadence == "daily" else o // 7


def _streaks(done_dates: set[date], cadence: str, today: date) -> tuple[int, int]:
    idxs = sorted({_period_index(d, cadence) for d in done_dates})
    if not idxs:
        return 0, 0
    longest = run = 1
    for i in range(1, len(idxs)):
        run = run + 1 if idxs[i] == idxs[i - 1] + 1 else 1
        longest = max(longest, run)
    seen = set(idxs)
    cur_period = _period_index(today, cadence)
    if cur_period not in seen:   # today's not logged yet — grace one period
        cur_period -= 1
    current = 0
    p = cur_period
    while p in seen:
        current += 1
        p -= 1
    return current, longest


async def analytics(db, user: User, habit_id: str) -> dict:
    h = await _owned(db, user, habit_id)
    today = utcnow().date()
    window_start = today - timedelta(days=_WINDOW_DAYS - 1)
    effective_start = max(window_start, h.created_at.date())

    res = await db.execute(
        select(HabitLog).where(
            HabitLog.habit_id == h.id,
            HabitLog.done.is_(True),
            HabitLog.date >= window_start,
        )
    )
    done_logs = list(res.scalars().all())
    done_dates = {e.date for e in done_logs}

    # Completion rate over the expected number of cadence-periods.
    span_days = max(1, (today - effective_start).days + 1)
    expected = span_days if h.cadence == "daily" else max(1, span_days // 7)
    done_periods = len({_period_index(d, h.cadence) for d in done_dates})
    completion_rate = round(min(1.0, done_periods / expected), 3)

    current_streak, longest_streak = _streaks(done_dates, h.cadence, today)

    correlation = await _correlation(db, user, h, done_dates, window_start)

    return {
        "habit_id": h.id,
        "name": h.name,
        "cadence": h.cadence,
        "completion_rate": completion_rate,
        "total_done": len(done_dates),
        "current_streak": current_streak,
        "longest_streak": longest_streak,
        "correlation": correlation,
    }


async def _correlation(db, user: User, habit: Habit, done_dates: set[date], window_start: date) -> dict | None:
    """Compare mood (or the target dimension) on done vs. not-done days."""
    if habit.target_dimension and habit.target_dimension in DIMENSION_LABELS:
        return await _dimension_correlation(db, user, habit, done_dates, window_start)
    return await _mood_correlation(db, user, done_dates, window_start)


def _summarise(label: str, done_avg: float | None, missed_avg: float | None,
               *, higher_is_better: bool, unit: str) -> dict | None:
    if done_avg is None or missed_avg is None:
        return None
    delta = round(done_avg - missed_avg, 2)
    good = (delta > 0) if higher_is_better else (delta < 0)
    direction = "higher" if delta > 0 else ("lower" if delta < 0 else "about the same")
    if abs(delta) < 0.15:
        insight = f"Your {label} is about the same whether or not you do this."
    else:
        tone = "better" if good else "worse"
        insight = (
            f"On days you do this, your {label} is {abs(delta):.1f} {unit} {direction} "
            f"— that looks {tone} for you."
        )
    return {
        "label": label,
        "done_avg": round(done_avg, 2),
        "missed_avg": round(missed_avg, 2),
        "delta": delta,
        "insight": insight,
    }


async def _mood_correlation(db, user: User, done_dates: set[date], window_start: date) -> dict | None:
    res = await db.execute(
        select(MoodEntry.created_at, MoodEntry.level).where(
            MoodEntry.user_id == user.id,
            MoodEntry.created_at >= datetime(window_start.year, window_start.month, window_start.day),
        )
    )
    by_day: dict[date, list[int]] = {}
    for created_at, level in res.all():
        by_day.setdefault(created_at.date(), []).append(level)
    done_vals, missed_vals = [], []
    for d, levels in by_day.items():
        avg = sum(levels) / len(levels)
        (done_vals if d in done_dates else missed_vals).append(avg)
    if not done_vals or not missed_vals:
        return None
    return _summarise(
        "mood",
        sum(done_vals) / len(done_vals),
        sum(missed_vals) / len(missed_vals),
        higher_is_better=True,
        unit="points",
    )


async def _dimension_correlation(db, user: User, habit: Habit, done_dates: set[date], window_start: date) -> dict | None:
    dim = habit.target_dimension
    res = await db.execute(
        select(EmotionalHistory.created_at, EmotionalHistory.score).where(
            EmotionalHistory.user_id == user.id,
            EmotionalHistory.dimension == dim,
            EmotionalHistory.created_at >= datetime(window_start.year, window_start.month, window_start.day),
        )
    )
    by_day: dict[date, list[float]] = {}
    for created_at, score in res.all():
        by_day.setdefault(created_at.date(), []).append(score)
    done_vals, missed_vals = [], []
    for d, scores in by_day.items():
        avg = sum(scores) / len(scores)
        (done_vals if d in done_dates else missed_vals).append(avg)
    if not done_vals or not missed_vals:
        return None
    # For negative dimensions lower is better; positives higher is better.
    from app.core.dimensions import POSITIVE_DIMENSIONS
    out = _summarise(
        DIMENSION_LABELS[dim].lower(),
        sum(done_vals) / len(done_vals),
        sum(missed_vals) / len(missed_vals),
        higher_is_better=dim in POSITIVE_DIMENSIONS,
        unit="points",
    )
    if out:
        out["dimension"] = dim
    return out
