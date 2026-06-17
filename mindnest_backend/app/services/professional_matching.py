"""Professional matching — gathers a user's MVP 1 signals and ranks pros.

This is the orchestration layer the spec calls for. The actual ranking is the
pure :mod:`app.ai.matching.engine`; here we *read* (never write) the user's
emotional profile, burnout risk, goals and focus areas from MVP 1 services and
load the candidate professionals (active + verified).
"""
from __future__ import annotations

from fastapi import HTTPException
from sqlalchemy import select

from app.ai.matching import engine
from app.models import Professional, VerificationStatus
from app.services import mood_service, onboarding_service, professional_service


async def gather_signals(db, user, *, extra: dict | None = None) -> dict:
    """Read-only snapshot of the user's emotional state for matching/referral."""
    dimensions: dict = {}
    burnout_risk = 0.0
    try:
        profile = await mood_service.latest_profile(db, user)
        dimensions = profile.dimensions or {}
        burnout_risk = float((profile.derived or {}).get("burnout_risk", 0.0))
    except HTTPException:
        pass  # no completed assessment yet → fall back to goals/focus only

    ob = await onboarding_service.status(db, user)
    signals = {
        "dimensions": dimensions,
        "burnout_risk": burnout_risk,
        "goals": ob.get("goals") or [],
        "focus_areas": ob.get("focus_areas") or [],
    }
    if extra:
        signals.update(extra)
    return signals


async def active_verified(db) -> list[Professional]:
    res = await db.execute(
        select(Professional).where(
            Professional.is_active.is_(True),
            Professional.verification_status == VerificationStatus.APPROVED,
        )
    )
    return list(res.scalars().all())


async def recommended(
    db,
    user,
    *,
    limit: int = 5,
    specializations: list[str] | None = None,
) -> list[dict]:
    """Ranked, explainable professional matches for a user."""
    signals = await gather_signals(db, user)
    pros = await active_verified(db)
    pro_dicts = [professional_service.to_public_out(p) for p in pros]

    if specializations:
        wanted = set(specializations)
        narrowed = [
            p for p in pro_dicts if wanted.intersection(p["specializations"])
        ]
        # Only narrow if at least one pro matches; otherwise rank everyone.
        pro_dicts = narrowed or pro_dicts

    return engine.rank_professionals(signals, pro_dicts, limit=limit)
