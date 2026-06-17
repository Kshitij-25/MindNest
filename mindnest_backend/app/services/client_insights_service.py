"""Consent-gated client insights for professionals.

A professional sees ONLY the slices a user has explicitly shared (active
:class:`ConsentRecord` scopes). Each section reads from the corresponding MVP 1
service — read-only — and raw private data (e.g. full journal bodies) is never
returned; journal *summaries* require their own scope.
"""
from __future__ import annotations

from fastapi import HTTPException, status
from sqlalchemy import select

from app.models import ConsentScope, JournalAnalysis, User
from app.services import (
    consent_service,
    insights_service,
    mood_service,
    onboarding_service,
    report_service,
)


async def view(db, pro, user_id: str) -> dict:
    ures = await db.execute(select(User).where(User.id == user_id))
    user = ures.scalar_one_or_none()
    if user is None:
        raise HTTPException(status.HTTP_404_NOT_FOUND, "Client not found")

    scopes = await consent_service.active_scopes(db, user_id, pro.id)
    if not scopes:
        raise HTTPException(
            status.HTTP_403_FORBIDDEN,
            "This client has not shared any data with you.",
        )

    sections: dict = {}

    if ConsentScope.EMOTIONAL_PROFILE in scopes:
        sections["emotional_profile"] = await _emotional_profile(db, user)

    if ConsentScope.INSIGHTS in scopes:
        sections["insights"] = await insights_service.insights(db, user, days=14)

    if ConsentScope.ASSESSMENT_HISTORY in scopes:
        sections["assessment_history"] = await _assessment_history(db, user)

    if ConsentScope.WELLNESS_REPORTS in scopes:
        sections["wellness_reports"] = await report_service.history(db, user, limit=8)

    if ConsentScope.JOURNAL_SUMMARIES in scopes:
        sections["journal_summaries"] = await _journal_summaries(db, user)

    return {
        "user_id": user_id,
        "display_name": user.display_name or user.email.split("@")[0],
        "shared_scopes": sorted(scopes),
        "sections": sections,
    }


async def _emotional_profile(db, user) -> dict | None:
    try:
        p = await mood_service.latest_profile(db, user)
    except HTTPException:
        return None
    summary = mood_service.profile_to_summary(p)
    ob = await onboarding_service.status(db, user)
    return {
        "overall_mood": summary["overall_mood"],
        "valence": summary["valence"],
        "summary": summary["summary"],
        "top_emotions": summary["top_emotions"],
        "dimensions": summary["dimensions"],
        "derived": summary["derived"],
        "goals": ob.get("goals") or [],
        "focus_areas": ob.get("focus_areas") or [],
        "created_at": summary["created_at"],
    }


async def _assessment_history(db, user) -> list[dict]:
    profiles = await mood_service.history(db, user, limit=10)
    return [
        {
            "assessment_id": p.assessment_id,
            "created_at": p.created_at,
            "overall_mood": p.overall_mood,
            "valence": p.valence,
            "burnout_risk": (p.derived or {}).get("burnout_risk"),
        }
        for p in profiles
    ]


async def _journal_summaries(db, user) -> list[dict]:
    res = await db.execute(
        select(JournalAnalysis)
        .where(JournalAnalysis.user_id == user.id)
        .order_by(JournalAnalysis.created_at.desc())
        .limit(15)
    )
    return [
        {
            "created_at": a.created_at,
            "emotion": a.emotion,
            "summary": a.summary,
            "themes": a.themes or [],
        }
        for a in res.scalars().all()
    ]
