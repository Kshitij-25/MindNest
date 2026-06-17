"""The professional matching engine — pure, deterministic, offline.

Mirrors the spirit of ``app.ai.recommendations.engine``: no I/O, no DB — just
maps a user's emotional signals onto a ranked, *explainable* list of
professionals. The service layer feeds it the signals (from the user's
:class:`MoodProfile`, burnout risk, goals and focus areas) and the candidate
professional dicts (``professional_service.to_public_out``).

A "signal" dict looks like::

    {
      "dimensions": {"stress": 72.0, "anxiety": 40.0, ...},  # 0..100
      "burnout_risk": 68.0,                                  # 0..100
      "goals": ["sleep better", "manage work stress"],
      "focus_areas": ["career", "sleep"],
    }
"""
from __future__ import annotations

from app.core import specializations as spec
from app.core.dimensions import DIMENSION_LABELS, POSITIVE_DIMENSIONS

# Which specializations a notable dimension points toward.
DIMENSION_SPEC_MAP: dict[str, list[str]] = {
    "stress": [spec.STRESS, spec.BURNOUT],
    "anxiety": [spec.ANXIETY],
    "sadness": [spec.SELF_ESTEEM, spec.PERSONAL_GROWTH],
    "happiness": [spec.PERSONAL_GROWTH],
    "burnout": [spec.BURNOUT, spec.STRESS],
    "fatigue": [spec.BURNOUT, spec.SLEEP],
    "loneliness": [spec.RELATIONSHIPS],
    "anger": [spec.RELATIONSHIPS, spec.PERSONAL_GROWTH],
    "instability": [spec.TRAUMA, spec.SELF_ESTEEM],
    "motivation": [spec.MOTIVATION, spec.CAREER],
}

# Free-text goal / focus-area keywords → specialization.
_KEYWORD_SPEC: list[tuple[tuple[str, ...], str]] = [
    (("sleep", "insomnia", "rest", "tired"), spec.SLEEP),
    (("career", "work", "job", "promotion", "workplace"), spec.CAREER),
    (("relationship", "partner", "family", "friend", "marriage", "lonely"), spec.RELATIONSHIPS),
    (("confidence", "self-esteem", "self esteem", "self worth", "worth"), spec.SELF_ESTEEM),
    (("growth", "purpose", "meaning", "mindful", "habit"), spec.PERSONAL_GROWTH),
    (("stress", "overwhelm", "pressure"), spec.STRESS),
    (("anxiety", "anxious", "worry", "panic"), spec.ANXIETY),
    (("burnout", "exhaust", "drained"), spec.BURNOUT),
    (("motivation", "motivated", "procrastinat", "focus"), spec.MOTIVATION),
    (("trauma", "ptsd", "grief", "loss", "abuse"), spec.TRAUMA),
]

_NOTABLE = 40.0  # salience floor for a dimension to drive demand


def _demand(signals: dict) -> tuple[dict[str, float], dict[str, list[str]]]:
    """Build a ``specialization -> demand`` map plus per-spec human reasons."""
    dims = signals.get("dimensions") or {}
    burnout_risk = float(signals.get("burnout_risk") or 0.0)
    demand: dict[str, float] = {}
    notes: dict[str, list[str]] = {}

    def bump(s: str, weight: float, reason: str | None) -> None:
        if weight <= 0:
            return
        demand[s] = demand.get(s, 0.0) + weight
        if reason:
            notes.setdefault(s, [])
            if reason not in notes[s]:
                notes[s].append(reason)

    for dim, raw in dims.items():
        val = float(raw)
        salience = (100.0 - val) if dim in POSITIVE_DIMENSIONS else val
        if salience < _NOTABLE:
            continue
        label = DIMENSION_LABELS.get(dim, dim).lower()
        reason = (
            f"your low {label}" if dim in POSITIVE_DIMENSIONS else f"your elevated {label}"
        )
        for s in DIMENSION_SPEC_MAP.get(dim, []):
            bump(s, salience, reason)

    if burnout_risk >= 45:
        for s in (spec.BURNOUT, spec.STRESS):
            bump(s, burnout_risk, "your burnout risk")

    text_items = [str(x).lower() for x in (signals.get("focus_areas") or [])]
    text_items += [str(x).lower() for x in (signals.get("goals") or [])]
    for t in text_items:
        for keys, s in _KEYWORD_SPEC:
            if any(k in t for k in keys):
                bump(s, 30.0, f"your focus on “{t}”")

    return demand, notes


def rank_professionals(
    signals: dict,
    professionals: list[dict],
    *,
    limit: int = 5,
) -> list[dict]:
    """Rank professionals for a user's signals.

    Returns ``[{"professional": <dict>, "score": float, "reasons": [str]}]``
    sorted by descending score. When the user shows no notable needs, ranking
    falls back to professional quality (rating + review volume).
    """
    demand, notes = _demand(signals)
    ranked: list[dict] = []

    for p in professionals:
        specs = list(p.get("specializations") or [])
        match = sum(demand.get(s, 0.0) for s in specs)

        rating = float(p.get("rating") or 0.0)
        reviews = int(p.get("review_count") or 0)
        quality = rating * 6.0 + min(reviews, 50) * 0.4
        score = match + quality

        matched = sorted(
            (s for s in specs if demand.get(s, 0.0) > 0),
            key=lambda s: demand[s],
            reverse=True,
        )
        reasons: list[str] = []
        for s in matched[:3]:
            why = notes.get(s) or []
            label = spec.label(s)
            if why:
                reasons.append(f"Specializes in {label}, matching {why[0]}.")
            else:
                reasons.append(f"Specializes in {label}.")
        if rating > 0 and reviews > 0:
            reasons.append(f"Rated {rating:.1f}/5 across {reviews} review(s).")
        if not reasons:
            reasons.append("Available on MindNest and accepting new clients.")

        ranked.append(
            {"professional": p, "score": round(score, 1), "reasons": reasons}
        )

    ranked.sort(key=lambda r: r["score"], reverse=True)
    return ranked[:limit]
