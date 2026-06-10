"""Mood check-in → dimension contribution mapping.

A check-in is a 1–5 level + optional life-area *factors* + an optional note.
This module turns those into ``scoring`` contributions so a check-in feeds the
exact same 10-dimension engine an assessment does — one timeline, one model.

* The **level** carries the core valence (happiness / motivation / sadness).
* **Stressor factors** attribute that low mood to specific negatives, scaled
  by how low the day is (picking "work" on a great day barely registers).
* **Uplift factors** add to the positives, scaled by how good the day is.
* The **note** is analysed by ``ai.pipeline.analyze_text`` elsewhere.
"""
from __future__ import annotations

from collections import defaultdict

from app.core.dimensions import (
    ANXIETY,
    BURNOUT,
    FATIGUE,
    HAPPINESS,
    LONELINESS,
    MOTIVATION,
    SADNESS,
    STRESS,
    ANGER,
)

# key -> (label, polarity, dimensions). Stressor dims are negative dimensions
# the factor pushes up on a low day; uplift dims are positives it lifts on a
# good day. The catalogue is the client's source of truth (GET /mood/factors).
FACTORS: list[dict] = [
    {"key": "work", "label": "Work", "polarity": "stressor", "dims": [STRESS, BURNOUT]},
    {"key": "study", "label": "Study", "polarity": "stressor", "dims": [STRESS, ANXIETY]},
    {"key": "money", "label": "Money", "polarity": "stressor", "dims": [STRESS, ANXIETY]},
    {"key": "health", "label": "Health", "polarity": "stressor", "dims": [ANXIETY, FATIGUE]},
    {"key": "family", "label": "Family", "polarity": "stressor", "dims": [STRESS, SADNESS]},
    {"key": "relationships", "label": "Relationships", "polarity": "stressor", "dims": [SADNESS, LONELINESS]},
    {"key": "conflict", "label": "Conflict", "polarity": "stressor", "dims": [ANGER, STRESS]},
    {"key": "sleep", "label": "Poor sleep", "polarity": "stressor", "dims": [FATIGUE, BURNOUT]},
    {"key": "news", "label": "News", "polarity": "stressor", "dims": [ANXIETY]},
    {"key": "future", "label": "The future", "polarity": "stressor", "dims": [ANXIETY]},
    {"key": "exercise", "label": "Exercise", "polarity": "uplift", "dims": [HAPPINESS, MOTIVATION]},
    {"key": "social", "label": "Socialising", "polarity": "uplift", "dims": [HAPPINESS, LONELINESS]},
    {"key": "friends", "label": "Friends", "polarity": "uplift", "dims": [HAPPINESS, LONELINESS]},
    {"key": "rest", "label": "Rest", "polarity": "uplift", "dims": [FATIGUE, STRESS]},
    {"key": "nature", "label": "Outdoors", "polarity": "uplift", "dims": [HAPPINESS, STRESS]},
    {"key": "hobby", "label": "Hobbies", "polarity": "uplift", "dims": [HAPPINESS, MOTIVATION]},
    {"key": "gratitude", "label": "Gratitude", "polarity": "uplift", "dims": [HAPPINESS, SADNESS]},
    {"key": "achievement", "label": "Achievement", "polarity": "uplift", "dims": [MOTIVATION, HAPPINESS]},
]

_FACTOR_BY_KEY = {f["key"]: f for f in FACTORS}

# Gains (points). Kept modest — the level is the primary signal.
_STRESSOR_GAIN = 16.0
_UPLIFT_GAIN = 16.0


def catalog() -> list[dict]:
    return [{"key": f["key"], "label": f["label"], "polarity": f["polarity"]} for f in FACTORS]


def label_for(key: str) -> str:
    spec = _FACTOR_BY_KEY.get(key)
    return spec["label"] if spec else key.replace("_", " ").title()


def level_contribution(level: int) -> dict:
    """The core valence contribution from the 1–5 mood level."""
    pos = (level - 1) / 4.0  # 0 (low) .. 1 (great)
    dims = {
        HAPPINESS: round((pos - 0.5) * 70.0, 1),
        MOTIVATION: round((pos - 0.5) * 45.0, 1),
        SADNESS: round((1 - pos) * 45.0, 1),
    }
    return {"dimensions": {d: v for d, v in dims.items() if abs(v) >= 0.5}}


def factor_contributions(level: int, factors: list[str]) -> list[dict]:
    """One contribution per recognised factor, modulated by the mood level."""
    pos = (level - 1) / 4.0
    neg_strength = 1.0 - pos
    out: list[dict] = []
    for key in factors or []:
        spec = _FACTOR_BY_KEY.get(key)
        if not spec:
            continue
        dims: dict[str, float] = defaultdict(float)
        if spec["polarity"] == "stressor":
            mag = _STRESSOR_GAIN * (0.35 + 0.65 * neg_strength)
            for d in spec["dims"]:
                dims[d] += round(mag, 1)
        else:  # uplift
            mag = _UPLIFT_GAIN * (0.35 + 0.65 * pos)
            for d in spec["dims"]:
                # Lifting a positive dimension adds; "lifting" a negative one
                # (e.g. rest → less fatigue) subtracts.
                if d in (HAPPINESS, MOTIVATION):
                    dims[d] += round(mag, 1)
                else:
                    dims[d] -= round(mag * 0.7, 1)
        kept = {d: v for d, v in dims.items() if abs(v) >= 0.5}
        if kept:
            out.append({"dimensions": kept})
    return out
