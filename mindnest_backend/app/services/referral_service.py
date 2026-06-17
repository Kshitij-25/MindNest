"""AI → human support handoff.

Composes the pure :mod:`app.ai.referral.engine` verdict with the user's MVP 1
signals (including a persistent-anxiety read from insight trends) and, when a
referral is warranted, the top professional matches. The copy is deliberately
supportive and **non-diagnostic** — MindNest only ever *suggests* human support.
"""
from __future__ import annotations

from app.ai.referral import engine
from app.services import insights_service, professional_matching


async def referral(db, user, *, user_requested: bool = False) -> dict:
    signals = await professional_matching.gather_signals(db, user)
    signals["persistent_anxiety"] = await _persistent_anxiety(db, user)
    signals["user_requested"] = user_requested

    verdict = engine.evaluate(signals)

    professionals: list[dict] = []
    if verdict["should_suggest"]:
        professionals = await professional_matching.recommended(
            db,
            user,
            limit=3,
            specializations=verdict["recommended_specializations"],
        )

    return {
        "should_suggest": verdict["should_suggest"],
        "severity": verdict["severity"],
        "reasons": verdict["reasons"],
        "recommended_specializations": verdict["recommended_specializations"],
        "message": _message(verdict),
        "professionals": professionals,
    }


async def _persistent_anxiety(db, user) -> bool:
    """True when anxiety has stayed elevated across at least a couple check-ins."""
    try:
        t = await insights_service.trends(db, user, days=21)
    except Exception:
        return False
    if t.get("samples", 0) < 2:
        return False
    for tr in t.get("trends", []):
        if tr["dimension"] == "anxiety" and tr["current"] >= 55:
            return True
    return False


def _message(verdict: dict) -> str:
    if not verdict["should_suggest"]:
        return (
            "You're tracking okay right now. Keep checking in — MindNest is here "
            "whenever you need it."
        )
    return (
        "Some of your recent signals suggest that talking with a human "
        "professional could help. This isn't a diagnosis or a medical opinion — "
        "just a gentle suggestion you're free to take at your own pace."
    )
