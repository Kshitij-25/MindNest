"""Weekly wellness reports (P0).

One cached ``WellnessReport`` per user per ISO week, assembling: mood summary +
trend, top topics, check-in/journal counts, streak, burnout/drift movement,
pattern cards (Pattern Detector), habit adherence and recommendation
follow-through. The narrative is LLM-written with a deterministic fallback.
Generation is idempotent; a fresh report emits an ``insight`` notification.
"""
from __future__ import annotations

from datetime import date, datetime, timedelta

from fastapi import HTTPException, status
from sqlalchemy import func, select

from app.ai.llm import ollama
from app.core.time_format import iso_week_key
from app.core.utils import utcnow
from app.models import (
    Habit,
    HabitLog,
    Journal,
    JournalAnalysis,
    MoodEntry,
    RecommendationFeedback,
    Streak,
    User,
    WellnessReport,
)
from app.services import analytics_service, notification_service


def _week_range(period_key: str | None, now: datetime) -> tuple[str, date, date]:
    if period_key:
        try:
            y, w = period_key.split("-W")
            monday = date.fromisocalendar(int(y), int(w), 1)
        except (ValueError, TypeError):
            raise HTTPException(status.HTTP_400_BAD_REQUEST, "Bad periodKey (expected YYYY-Www)")
    else:
        today = now.date()
        monday = today - timedelta(days=today.isoweekday() - 1)
        period_key = iso_week_key(now)
    return period_key, monday, monday + timedelta(days=7)


def _trend_label(levels: list[int]) -> str:
    if len(levels) < 2:
        return "Steady"
    mid = len(levels) // 2
    a = sum(levels[:mid]) / max(1, mid)
    b = sum(levels[mid:]) / max(1, len(levels) - mid)
    if b - a >= 0.4:
        return "Improving"
    if b - a <= -0.4:
        return "Declining"
    return "Steady"


_MOOD_LABELS = ["Struggling", "Low", "Okay", "Good", "Great"]


def _mood_label(average: float) -> str:
    if average <= 0:
        return "—"
    return _MOOD_LABELS[min(4, max(0, round(average) - 1))]


def _change_pct(levels: list[int]) -> str:
    """Within-week mood slope as a signed percentage string."""
    if len(levels) < 2:
        return "0%"
    mid = len(levels) // 2
    a = sum(levels[:mid]) / max(1, mid)
    b = sum(levels[mid:]) / max(1, len(levels) - mid)
    if a == 0:
        return "0%"
    pct = round((b - a) / a * 100)
    return f"{'+' if pct >= 0 else ''}{pct}%"


async def _compute_payload(db, user: User, period_key: str, start: date, end: date) -> dict:
    start_dt = datetime(start.year, start.month, start.day)
    end_dt = datetime(end.year, end.month, end.day)

    # Mood entries this week
    mres = await db.execute(
        select(MoodEntry.created_at, MoodEntry.level).where(
            MoodEntry.user_id == user.id,
            MoodEntry.created_at >= start_dt,
            MoodEntry.created_at < end_dt,
        ).order_by(MoodEntry.created_at)
    )
    rows = mres.all()
    levels = [lvl for _, lvl in rows]
    avg_mood = round(sum(levels) / len(levels), 1) if levels else 0.0

    # Journal count + top topics this week
    jres = await db.execute(
        select(JournalAnalysis.topics)
        .join(Journal, Journal.id == JournalAnalysis.journal_id)
        .where(
            Journal.user_id == user.id,
            Journal.created_at >= start_dt,
            Journal.created_at < end_dt,
        )
    )
    from collections import Counter, defaultdict
    topic_counts: Counter = Counter()
    for (topics,) in jres.all():
        for t in (topics or []):
            if t.get("name"):
                topic_counts[t["name"]] += 1
    top_topics = [
        {"topic": name, "count": n} for name, n in topic_counts.most_common(5)
    ]

    # Best / hardest day by average mood level.
    by_day: dict[str, list[int]] = defaultdict(list)
    for dt, lvl in rows:
        by_day[dt.strftime("%A")].append(lvl)
    day_avgs = {d: sum(v) / len(v) for d, v in by_day.items()}
    best_day = max(day_avgs, key=day_avgs.get) if day_avgs else ""
    hardest_day = min(day_avgs, key=day_avgs.get) if day_avgs else ""

    journal_count = await _count(db, Journal, user.id, start_dt, end_dt, draft=False)

    # Streak snapshot
    sres = await db.execute(select(Streak).where(Streak.user_id == user.id))
    streak = sres.scalar_one_or_none()

    # Habit adherence: done-logs / (active habits * 7), capped at 1.
    active_habits = await _scalar(
        db, select(func.count()).select_from(Habit).where(
            Habit.user_id == user.id, Habit.active.is_(True)
        )
    )
    habit_done = await _scalar(
        db, select(func.count()).select_from(HabitLog).where(
            HabitLog.user_id == user.id,
            HabitLog.done.is_(True),
            HabitLog.date >= start,
            HabitLog.date < end,
        )
    )
    adherence = round(min(1.0, habit_done / (active_habits * 7)), 3) if active_habits else 0.0

    # Recommendation follow-through this week
    fres = await db.execute(
        select(RecommendationFeedback.action).where(
            RecommendationFeedback.user_id == user.id,
            RecommendationFeedback.created_at >= start_dt,
            RecommendationFeedback.created_at < end_dt,
        )
    )
    actions = [a for (a,) in fres.all()]
    follow_through = {
        "accepted": sum(1 for a in actions if a == "accepted"),
        "completed": sum(1 for a in actions if a == "completed"),
        "dismissed": sum(1 for a in actions if a == "dismissed"),
    }

    # Pattern cards + dimension drifts (timeline) over the recent window.
    patterns = (await analytics_service.patterns_view(db, user, days=30))["patterns"]
    changes = (
        await analytics_service.emotional_timeline_view(db, user, days=30)
    )["changes"]

    # Top emotional changes by magnitude; burnout movement; growth areas.
    ranked = sorted(changes, key=lambda c: abs(c.get("drift", 0)), reverse=True)
    emotional_changes = [
        {"key": c.get("label", c.get("dimension", "")), "delta": round(c.get("drift", 0))}
        for c in ranked[:4]
    ]
    burnout_movement = next(
        (round(c.get("drift", 0)) for c in changes if c.get("dimension") == "burnout"),
        0,
    )
    growth_areas = [
        f"Tend to your {c.get('label', '').lower()}"
        for c in changes
        if not c.get("improving", True)
    ][:2]
    if not growth_areas:
        growth_areas = ["Keep your check-in rhythm", "Protect your wind-down"]

    suggested_focus = (
        top_topics[0]["topic"]
        if top_topics
        else (ranked[0].get("label", "Consistency") if ranked else "Consistency")
    )

    return {
        "period_key": period_key,
        "range": {"start": start.isoformat(), "end": (end - timedelta(days=1)).isoformat()},
        "mood": {
            "average": avg_mood,
            "avg_level": round(avg_mood),
            "avg_label": _mood_label(avg_mood),
            "trend_label": _trend_label(levels),
            "change": _change_pct(levels),
            "check_ins": len(levels),
            "best_day": best_day,
            "hardest_day": hardest_day,
        },
        "journal_count": journal_count,
        "top_topics": top_topics,
        "streak": streak.current if streak else 0,
        "habit_adherence": adherence,
        "follow_through": follow_through,
        "patterns": patterns,
        "emotional_changes": emotional_changes,
        "burnout_movement": burnout_movement,
        "growth_areas": growth_areas,
        "suggested_focus": suggested_focus,
    }


async def _narrative(payload: dict) -> str:
    mood = payload["mood"]
    topics = payload["top_topics"]
    parts = []
    if mood["check_ins"]:
        parts.append(
            f"This week you checked in {mood['check_ins']} time(s), with an average "
            f"mood of {mood['average']}/5 ({mood['trend_label'].lower()})."
        )
    else:
        parts.append("You didn't check in much this week — even a quick daily note helps.")
    if topics:
        names = ", ".join(t["topic"] for t in topics[:3])
        parts.append(f"Your entries circled around {names}.")
    if payload["streak"]:
        parts.append(f"You're on a {payload['streak']}-day streak — nice consistency.")
    if payload["patterns"]:
        parts.append(payload["patterns"][0]["body"])
    template = " ".join(parts)

    if ollama.enabled:
        system = (
            "You are MindNest, a warm wellbeing companion. Rewrite the weekly "
            "summary as 3-4 supportive sentences to the person as 'you'. No lists, "
            "no headings, no preamble. Keep every fact; add warmth, not new claims."
        )
        out = await ollama.generate(f"Weekly summary facts: {template}", system=system)
        if out:
            return out
    return template


async def weekly(db, user: User, period_key: str | None = None, *, refresh: bool = False) -> dict:
    now = utcnow()
    pk, start, end = _week_range(period_key, now)

    res = await db.execute(
        select(WellnessReport).where(
            WellnessReport.user_id == user.id, WellnessReport.period_key == pk
        )
    )
    report = res.scalar_one_or_none()
    if report is not None and not refresh:
        return _to_out(report)

    payload = await _compute_payload(db, user, pk, start, end)
    narrative = await _narrative(payload)

    is_new = report is None
    if report is None:
        report = WellnessReport(user_id=user.id, period_key=pk)
        db.add(report)
    report.payload = payload
    report.narrative = narrative
    report.generated_at = now

    if is_new:
        await notification_service.create(
            db, user=user, type="insight",
            title="Your weekly wellness report is ready",
            body=narrative[:160],
            ref_id=pk,
        )
    await db.commit()
    await db.refresh(report)
    return _to_out(report)


async def history(db, user: User, *, limit: int = 12) -> list[dict]:
    res = await db.execute(
        select(WellnessReport)
        .where(WellnessReport.user_id == user.id)
        .order_by(WellnessReport.generated_at.desc())
        .limit(limit)
    )
    return [_to_out(r) for r in res.scalars().all()]


def _to_out(r: WellnessReport) -> dict:
    return {
        "period_key": r.period_key,
        "narrative": r.narrative,
        "generated_at": r.generated_at,
        **(r.payload or {}),
    }


# ---- small query helpers -----------------------------------------------------


async def _scalar(db, stmt) -> int:
    return int((await db.execute(stmt)).scalar() or 0)


async def _count(db, model, user_id, start_dt, end_dt, **filters) -> int:
    stmt = select(func.count()).select_from(model).where(
        model.user_id == user_id,
        model.created_at >= start_dt,
        model.created_at < end_dt,
    )
    for k, v in filters.items():
        stmt = stmt.where(getattr(model, k) == v)
    return int((await db.execute(stmt)).scalar() or 0)
