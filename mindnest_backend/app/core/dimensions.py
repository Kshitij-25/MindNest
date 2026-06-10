"""The emotional dimension taxonomy — the shared vocabulary of MindNest.

Both the rule-based scorer and the transformer/LLM layers speak in these
ten dimensions so their signals can be merged on a common scale (0..100,
where higher always means "more of this dimension is present").
"""
from __future__ import annotations

# Canonical dimension keys (order is the display order).
STRESS = "stress"
ANXIETY = "anxiety"
SADNESS = "sadness"
HAPPINESS = "happiness"
BURNOUT = "burnout"
FATIGUE = "fatigue"            # emotional fatigue
LONELINESS = "loneliness"
ANGER = "anger"
INSTABILITY = "instability"   # emotional instability
MOTIVATION = "motivation"

DIMENSIONS: list[str] = [
    STRESS,
    ANXIETY,
    SADNESS,
    HAPPINESS,
    BURNOUT,
    FATIGUE,
    LONELINESS,
    ANGER,
    INSTABILITY,
    MOTIVATION,
]

# Positive-valence dimensions: more is "good". Everything else is negative.
POSITIVE_DIMENSIONS: set[str] = {HAPPINESS, MOTIVATION}
NEGATIVE_DIMENSIONS: set[str] = set(DIMENSIONS) - POSITIVE_DIMENSIONS

# Human-friendly labels for summaries / UI.
DIMENSION_LABELS: dict[str, str] = {
    STRESS: "Stress",
    ANXIETY: "Anxiety",
    SADNESS: "Sadness",
    HAPPINESS: "Happiness",
    BURNOUT: "Burnout risk",
    FATIGUE: "Emotional fatigue",
    LONELINESS: "Loneliness",
    ANGER: "Anger",
    INSTABILITY: "Emotional instability",
    MOTIVATION: "Motivation",
}

# Starting score before any evidence. Positive dims start near neutral;
# negative dims start low and rise only with evidence.
BASELINES: dict[str, float] = {
    **{d: 45.0 for d in POSITIVE_DIMENSIONS},
    **{d: 6.0 for d in NEGATIVE_DIMENSIONS},
}


def empty_scores() -> dict[str, float]:
    """A fresh score vector at baseline."""
    return dict(BASELINES)


def is_high(dimension: str, score: float) -> bool:
    """Is this dimension 'elevated'? (valence-aware)."""
    if dimension in POSITIVE_DIMENSIONS:
        return score <= 30.0   # low positive == a concern
    return score >= 55.0       # high negative == a concern


# ---- Mapping transformer emotion labels -> our dimensions ----
# Keyed by the labels emitted by j-hartmann/emotion-english-distilroberta-base.
# Each maps to (dimension, weight). Weights are multiplied by the model's
# probability for that label (0..1) and then by a global gain in the pipeline.
EMOTION_LABEL_TO_DIMENSIONS: dict[str, list[tuple[str, float]]] = {
    "anger": [(ANGER, 1.0), (INSTABILITY, 0.4), (STRESS, 0.3)],
    "disgust": [(ANGER, 0.5), (INSTABILITY, 0.3)],
    "fear": [(ANXIETY, 1.0), (STRESS, 0.5), (INSTABILITY, 0.3)],
    "joy": [(HAPPINESS, 1.0), (MOTIVATION, 0.5), (SADNESS, -0.6), (LONELINESS, -0.3)],
    "sadness": [(SADNESS, 1.0), (LONELINESS, 0.4), (MOTIVATION, -0.5), (FATIGUE, 0.3)],
    "surprise": [(INSTABILITY, 0.4)],
    "neutral": [],
}
