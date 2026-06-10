"""Recommendation generation + the feedback learning loop.

``regenerate`` reads the user's latest :class:`MoodProfile`, runs the pure
:mod:`app.ai.recommendations.engine`, applies a per-kind preference weight
learned from past feedback, and refreshes the user's *active* set. Feedback
(``POST /recommendations/{id}/feedback``) is persisted with a denormalised
``kind`` so the weights survive even when stale active rows are pruned.
"""
from __future__ import annotations

from fastapi import HTTPException, status

from sqlalchemy import select

from app.ai.recommendations import engine
from app.core.dimensions import empty_scores
from app.models import (
    MoodProfile,
    Recommendation,
    RecommendationFeedback,
    RecommendationStatus,
    User,
)

_POSITIVE_ACTIONS = {"accepted", "completed", "helpful"}
_NEGATIVE_ACTIONS = {"dismissed", "not_helpful"}
_ALLOWED_ACTIONS = _POSITIVE_ACTIONS | _NEGATIVE_ACTIONS
# Which feedback actions move a recommendation to a terminal status.
_ACTION_TO_STATUS = {
    "accepted": RecommendationStatus.ACCEPTED,
    "completed": RecommendationStatus.COMPLETED,
    "dismissed": RecommendationStatus.DISMISSED,
}


async def _latest_state(db, user: User) -> tuple[dict, dict]:
    """The most recent (scores, derived) for this user, or baseline if none."""
    res = await db.execute(
        select(MoodProfile)
        .where(MoodProfile.user_id == user.id)
        .order_by(MoodProfile.created_at.desc())
        .limit(1)
    )
    p = res.scalar_one_or_none()
    if p is None:
        return empty_scores(), {}
    return (p.dimensions or {}), (p.derived or {})


async def _feedback_weights(db, user: User) -> dict[str, float]:
    """Per-kind multiplier in [0.4, 1.8] learned from prior feedback.

    Positive feedback (accepted/completed/helpful) up-ranks a kind; negative
    feedback (dismissed/not_helpful) down-ranks it. A simple, transparent loop.
    """
    res = await db.execute(
        select(RecommendationFeedback.kind, RecommendationFeedback.action)
        .where(RecommendationFeedback.user_id == user.id)
    )
    tally: dict[str, int] = {}
    for kind, action in res.all():
        if not kind:
            continue
        if action in _POSITIVE_ACTIONS:
            tally[kind] = tally.get(kind, 0) + 1
        elif action in _NEGATIVE_ACTIONS:
            tally[kind] = tally.get(kind, 0) - 1
    return {k: max(0.4, min(1.8, 1.0 + 0.12 * n)) for k, n in tally.items()}


async def regenerate(db, user: User) -> list[Recommendation]:
    """Refresh the user's active recommendation set from their latest state."""
    scores, derived = await _latest_state(db, user)
    candidates = engine.recommend(scores, derived)

    weights = await _feedback_weights(db, user)
    for c in candidates:
        c["score"] = round(c["score"] * weights.get(c["kind"], 1.0), 1)
    candidates.sort(key=lambda c: c["score"], reverse=True)

    # Prune the current ACTIVE set, but never delete rows that carry feedback
    # (those hold a terminal status and feed the learning loop above).
    fb_res = await db.execute(
        select(RecommendationFeedback.recommendation_id)
        .where(RecommendationFeedback.user_id == user.id)
    )
    keep_ids = {row[0] for row in fb_res.all()}
    stale = await db.execute(
        select(Recommendation).where(
            Recommendation.user_id == user.id,
            Recommendation.status == RecommendationStatus.ACTIVE,
        )
    )
    for rec in stale.scalars().all():
        if rec.id not in keep_ids:
            await db.delete(rec)

    fresh: list[Recommendation] = []
    for c in candidates:
        rec = Recommendation(
            user_id=user.id,
            kind=c["kind"],
            title=c["title"],
            body=c["body"],
            score=c["score"],
            reason=c["reason"],
            source=c["source"],
            status=RecommendationStatus.ACTIVE,
        )
        db.add(rec)
        fresh.append(rec)

    await db.commit()
    for rec in fresh:
        await db.refresh(rec)
    return fresh


async def list_active(
    db, user: User, *, regenerate_if_empty: bool = True
) -> list[Recommendation]:
    res = await db.execute(
        select(Recommendation)
        .where(
            Recommendation.user_id == user.id,
            Recommendation.status == RecommendationStatus.ACTIVE,
        )
        .order_by(Recommendation.score.desc())
    )
    recs = list(res.scalars().all())
    if not recs and regenerate_if_empty:
        recs = await regenerate(db, user)
    return recs


async def feedback(db, user: User, rec_id: str, action: str) -> Recommendation:
    if action not in _ALLOWED_ACTIONS:
        raise HTTPException(
            status.HTTP_400_BAD_REQUEST,
            f"Unknown feedback action '{action}'.",
        )
    res = await db.execute(select(Recommendation).where(Recommendation.id == rec_id))
    rec = res.scalar_one_or_none()
    if rec is None or rec.user_id != user.id:
        raise HTTPException(status.HTTP_404_NOT_FOUND, "Recommendation not found")

    db.add(RecommendationFeedback(
        recommendation_id=rec.id,
        user_id=user.id,
        action=action,
        kind=rec.kind,
    ))
    new_status = _ACTION_TO_STATUS.get(action)
    if new_status:
        rec.status = new_status
    await db.commit()
    await db.refresh(rec)
    return rec
