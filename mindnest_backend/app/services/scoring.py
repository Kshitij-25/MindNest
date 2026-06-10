"""The mood scoring engine.

Turns a list of answers into the full 0..100 dimension vector, plus
per-dimension confidence, contradiction flags, derived metrics
(burnout risk, instability, ...), valence/arousal and an overall mood
label. Pure functions, no I/O — trivially unit-testable.
"""
from __future__ import annotations

from collections import defaultdict

from app.core.dimensions import (
    ANGER,
    ANXIETY,
    BURNOUT,
    DIMENSION_LABELS,
    DIMENSIONS,
    FATIGUE,
    HAPPINESS,
    INSTABILITY,
    LONELINESS,
    MOTIVATION,
    POSITIVE_DIMENSIONS,
    SADNESS,
    STRESS,
    BASELINES,
    empty_scores,
    is_high,
)

# ---- per-answer contribution -------------------------------------------------


def targeted_dimensions(question: dict) -> set[str]:
    """Which dimensions could this question move? (used by the adaptive engine)."""
    dims: set[str] = set()
    for opt in question.get("options", []) or []:
        dims.update((opt.get("scores") or {}).keys())
    dims.update((question.get("dimension_scale") or {}).keys())
    d = question.get("dimension")
    if d and d != "general":
        dims.add(d)
    if question.get("type") in ("free_text", "journal"):
        dims.update(question.get("nlp_focus") or DIMENSIONS)
    return {d for d in dims if d in DIMENSIONS}


def _slider_contribution(question: dict, value: float) -> dict[str, float]:
    sl = question.get("slider", {}) or {}
    mn, mx = float(sl.get("min", 0)), float(sl.get("max", 10))
    frac = 0.0 if mx == mn else max(0.0, min(1.0, (value - mn) / (mx - mn)))
    out: dict[str, float] = {}
    for dim, factor in (question.get("dimension_scale") or {}).items():
        if dim in POSITIVE_DIMENSIONS:
            out[dim] = round((frac - 0.5) * 2.0 * factor, 1)  # centered
        else:
            out[dim] = round(frac * factor, 1)                # direct
    return out


def score_answer(question: dict, raw: dict, nlp_result: dict | None = None) -> dict:
    """Compute dimension deltas for a single answer.

    ``nlp_result`` is the output of ``ai.pipeline.analyze_text`` for free
    text answers (may be ``None`` if the answer isn't text or text was empty).
    """
    qtype = question.get("type")
    if raw.get("skipped"):
        return {"dimensions": {}, "skipped": True, "type": qtype}

    dims: dict[str, float] = {}
    if qtype in ("multiple_choice", "emoji"):
        opt_id = raw.get("option_id")
        for opt in question.get("options", []) or []:
            if opt.get("id") == opt_id:
                dims = dict(opt.get("scores") or {})
                break
    elif qtype == "slider":
        if raw.get("value") is not None:
            dims = _slider_contribution(question, float(raw["value"]))
    elif qtype in ("free_text", "journal"):
        if nlp_result:
            dims = dict(nlp_result.get("dimensions") or {})

    dims = {d: float(v) for d, v in dims.items() if d in DIMENSIONS and abs(v) >= 0.5}
    return {"dimensions": dims, "skipped": False, "type": qtype, "nlp": nlp_result}


# ---- aggregation -------------------------------------------------------------

_SIGN_CONFLICT_MIN = 16.0  # min of opposing magnitudes to flag a contradiction


def _confidence(signals: list[float]) -> tuple[float, float, float]:
    """Return (confidence, pos_mag, neg_mag) for a dimension's signal list."""
    if not signals:
        return 0.0, 0.0, 0.0
    pos = sum(s for s in signals if s > 0)
    neg = -sum(s for s in signals if s < 0)
    total = pos + neg
    agreement = 1.0 if total == 0 else 1.0 - (min(pos, neg) / total)
    n = len(signals)
    coverage = 1.0 - (0.6 ** n)            # more evidence -> higher
    conf = coverage * (0.4 + 0.6 * agreement)
    return round(max(0.0, min(1.0, conf)), 3), pos, neg


def aggregate(contributions: list[dict]) -> dict:
    """Aggregate per-answer contributions into a full score state.

    ``contributions`` is a list of ``score_answer(...)`` results in order.
    """
    scores = empty_scores()
    signals: dict[str, list[float]] = defaultdict(list)
    touched: set[str] = set()

    for c in contributions:
        for dim, delta in (c.get("dimensions") or {}).items():
            scores[dim] = scores[dim] + delta
            signals[dim].append(delta)
            touched.add(dim)

    scores = {d: round(max(0.0, min(100.0, v)), 1) for d, v in scores.items()}

    confidence: dict[str, float] = {}
    contradictions: list[dict] = []
    for dim in DIMENSIONS:
        conf, pos, neg = _confidence(signals.get(dim, []))
        confidence[dim] = conf
        if min(pos, neg) >= _SIGN_CONFLICT_MIN:
            contradictions.append({
                "type": "within_dimension",
                "dimensions": [dim],
                "detail": f"Mixed signals about {DIMENSION_LABELS[dim].lower()} "
                          f"(+{round(pos)} / -{round(neg)}).",
            })

    contradictions.extend(_cross_dimension_contradictions(scores))

    derived = _derived_metrics(scores)
    valence, arousal = _valence_arousal(scores)
    overall_mood = _mood_label(scores, valence, derived)
    overall_conf = _overall_confidence(scores, confidence, touched)
    top = _top_emotions(scores)

    return {
        "scores": scores,
        "confidence": confidence,
        "overall_confidence": overall_conf,
        "valence": valence,
        "arousal": arousal,
        "overall_mood": overall_mood,
        "top_emotions": top,
        "derived": derived,
        "contradictions": contradictions,
        "touched": sorted(touched),
    }


def _cross_dimension_contradictions(scores: dict[str, float]) -> list[dict]:
    out: list[dict] = []
    pairs = [
        (HAPPINESS, SADNESS, "feeling happy yet also quite sad"),
        (MOTIVATION, BURNOUT, "feeling motivated yet also burned out"),
        (HAPPINESS, LONELINESS, "feeling happy yet quite lonely"),
    ]
    for a, b, detail in pairs:
        if scores[a] >= 55 and scores[b] >= 55:
            out.append({
                "type": "cross_dimension",
                "dimensions": [a, b],
                "detail": f"Conflicting state: {detail}.",
            })
    return out


def _derived_metrics(s: dict[str, float]) -> dict:
    burnout_risk = (
        0.32 * s[BURNOUT]
        + 0.24 * s[STRESS]
        + 0.22 * s[FATIGUE]
        + 0.12 * (100.0 - s[MOTIVATION])
        + 0.10 * s[LONELINESS]
    )
    burnout_risk = round(max(0.0, min(100.0, burnout_risk)), 1)
    instability = round(
        max(0.0, min(100.0, 0.7 * s[INSTABILITY] + 0.3 * s[ANGER])), 1
    )
    return {
        "burnout_risk": burnout_risk,
        "burnout_label": _band(burnout_risk),
        "emotional_fatigue": s[FATIGUE],
        "emotional_instability": instability,
        "loneliness": s[LONELINESS],
        "anger": s[ANGER],
        "motivation": s[MOTIVATION],
    }


def _band(v: float) -> str:
    if v >= 75:
        return "severe"
    if v >= 55:
        return "high"
    if v >= 35:
        return "moderate"
    return "low"


def _valence_arousal(s: dict[str, float]) -> tuple[float, float]:
    positive = (s[HAPPINESS] + s[MOTIVATION]) / 2.0
    negatives = [s[STRESS], s[ANXIETY], s[SADNESS], s[ANGER],
                 s[LONELINESS], s[FATIGUE], s[BURNOUT], s[INSTABILITY]]
    negativity = sum(negatives) / len(negatives)
    valence = round(max(-100.0, min(100.0, positive - negativity)), 1)
    arousal = round(
        max(0.0, min(100.0,
            (s[ANXIETY] + s[ANGER] + s[STRESS] + s[INSTABILITY]) / 4.0)), 1
    )
    return valence, arousal


def _overall_confidence(scores, confidence, touched) -> float:
    if not touched:
        return 0.2
    num = den = 0.0
    for d in touched:
        salience = abs(scores[d] - BASELINES[d]) + 10.0
        num += confidence[d] * salience
        den += salience
    base = num / den if den else 0.0
    # breadth bonus: covering more dimensions raises trust a little
    breadth = min(1.0, len(touched) / 6.0)
    return round(max(0.0, min(1.0, 0.85 * base + 0.15 * breadth)), 3)


def _top_emotions(scores: dict[str, float], k: int = 4) -> list[dict]:
    ranked = []
    for d in DIMENSIONS:
        salience = (100.0 - scores[d]) if d in POSITIVE_DIMENSIONS else scores[d]
        ranked.append((d, scores[d], salience))
    ranked.sort(key=lambda t: t[2], reverse=True)
    return [
        {"dimension": d, "label": DIMENSION_LABELS[d], "score": sc, "elevated": is_high(d, sc)}
        for d, sc, sal in ranked[:k]
    ]


def _mood_label(scores: dict[str, float], valence: float, derived: dict) -> str:
    s = scores
    if derived["burnout_risk"] >= 60 and s[FATIGUE] >= 55:
        return "Burned out and depleted"
    if s[ANGER] >= 55 or (s[INSTABILITY] >= 60 and s[ANGER] >= 40):
        return "Irritable and on edge"
    if s[ANXIETY] >= 55 and s[STRESS] >= 50:
        return "Stressed and anxious"
    if s[ANXIETY] >= 58:
        return "Anxious and tense"
    if s[SADNESS] >= 55 and s[LONELINESS] >= 50:
        return "Low and withdrawn"
    if s[SADNESS] >= 55:
        return "Sad and heavy"
    if s[STRESS] >= 58:
        return "Under pressure"
    if valence >= 30 and s[MOTIVATION] >= 60:
        return "Upbeat and motivated"
    if valence >= 22:
        return "Positive and steady"
    if valence <= -22:
        return "Struggling overall"
    return "Mixed and neutral"
