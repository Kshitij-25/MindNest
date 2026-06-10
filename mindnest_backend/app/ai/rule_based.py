"""Rule-based lexical mood scorer.

The always-on, zero-dependency layer. It reads free text and emits
dimension deltas using an emotion lexicon with light negation and
intensifier handling. On its own it gives MindNest a meaningful offline
signal; combined with the transformer it sharpens the read.

This is intentionally simple and transparent (you can explain every
point it assigns) — not a replacement for the ML layers, but a robust
floor that never fails to load.
"""
from __future__ import annotations

import re
from collections import defaultdict

from app.core.dimensions import (
    ANGER,
    ANXIETY,
    BURNOUT,
    FATIGUE,
    HAPPINESS,
    LONELINESS,
    MOTIVATION,
    SADNESS,
    STRESS,
)

# dimension -> {term: weight}.  Multi-word terms are matched as phrases.
LEXICON: dict[str, dict[str, float]] = {
    STRESS: {
        "stress": 1.0, "stressed": 1.2, "stressful": 1.1, "pressure": 0.9,
        "overwhelmed": 1.3, "overwhelming": 1.2, "too much": 1.0, "deadline": 0.8,
        "tense": 0.9, "can't cope": 1.4, "cant cope": 1.4, "swamped": 1.0,
    },
    ANXIETY: {
        "anxious": 1.3, "anxiety": 1.3, "worried": 1.1, "worry": 1.0,
        "nervous": 1.0, "panic": 1.4, "panicking": 1.4, "scared": 1.0,
        "afraid": 1.0, "on edge": 1.2, "restless": 0.9, "dread": 1.2,
        "racing thoughts": 1.2, "what if": 0.7,
    },
    SADNESS: {
        "sad": 1.2, "down": 0.9, "depressed": 1.4, "hopeless": 1.5,
        "empty": 1.2, "miserable": 1.3, "crying": 1.2, "cry": 1.0,
        "unhappy": 1.1, "low": 0.8, "numb": 1.1, "worthless": 1.4, "grief": 1.2,
    },
    HAPPINESS: {
        "happy": 1.3, "great": 0.9, "good": 0.6, "joy": 1.3, "joyful": 1.3,
        "excited": 1.1, "grateful": 1.0, "content": 0.9, "relaxed": 0.8,
        "hopeful": 1.0, "proud": 0.9, "love": 0.7, "wonderful": 1.1, "calm": 0.7,
    },
    BURNOUT: {
        "burnt out": 1.5, "burned out": 1.5, "burnout": 1.5, "fed up": 1.0,
        "checked out": 1.1, "running on empty": 1.3, "nothing left": 1.2,
        "can't keep up": 1.2, "cant keep up": 1.2,
    },
    FATIGUE: {
        "tired": 1.1, "exhausted": 1.4, "drained": 1.3, "fatigue": 1.2,
        "fatigued": 1.2, "no energy": 1.3, "worn out": 1.2, "sleepy": 0.8,
        "weary": 1.0, "depleted": 1.2,
    },
    LONELINESS: {
        "lonely": 1.4, "alone": 1.1, "isolated": 1.3, "no one": 1.0,
        "nobody": 1.1, "left out": 1.1, "disconnected": 1.0, "unwanted": 1.2,
        "by myself": 0.8,
    },
    ANGER: {
        "angry": 1.3, "anger": 1.2, "furious": 1.4, "irritated": 1.0,
        "irritable": 1.1, "annoyed": 0.9, "frustrated": 1.1, "rage": 1.4,
        "resentful": 1.1, "snap": 0.9, "pissed": 1.2, "fed up": 0.8,
    },
    MOTIVATION: {
        "motivated": 1.2, "driven": 1.0, "productive": 1.0, "focused": 0.9,
        "energized": 1.1, "inspired": 1.1, "unmotivated": -1.3,
        "no motivation": -1.4, "can't be bothered": -1.2, "cant be bothered": -1.2,
        "procrastinating": -0.9, "lazy": -0.7, "stuck": -0.8,
    },
}

_NEGATIONS = {"not", "no", "never", "n't", "without", "hardly", "barely", "isn't",
              "isnt", "wasn't", "wasnt", "don't", "dont", "didn't", "didnt"}
_INTENSIFIERS = {"very": 1.5, "really": 1.4, "so": 1.3, "extremely": 1.8,
                 "incredibly": 1.7, "super": 1.4, "totally": 1.4, "absolutely": 1.6,
                 "completely": 1.6, "a bit": 0.6, "slightly": 0.5, "somewhat": 0.7,
                 "kind of": 0.6, "kinda": 0.6}

# Points awarded to a dimension per unit of (weighted) lexical evidence.
_HIT_POINTS = 16.0
_MAX_PER_DIM = 46.0
_TOKEN_RE = re.compile(r"[a-z']+")


def _tokens(text: str) -> list[str]:
    return _TOKEN_RE.findall(text.lower())


def analyze(text: str) -> dict:
    """Return ``{"dimensions": {dim: delta}, "matched": [...], "tokens": n}``.

    Deltas can be negative (e.g. "not stressed", or "unmotivated" for the
    positive MOTIVATION dimension).
    """
    text = (text or "").strip()
    if not text:
        return {"dimensions": {}, "matched": [], "tokens": 0}

    low = " " + text.lower() + " "
    tokens = _tokens(text)
    raw: dict[str, float] = defaultdict(float)
    matched: list[dict] = []

    for dimension, terms in LEXICON.items():
        for term, weight in terms.items():
            # phrase match (padded substring) or single-token match
            if " " in term:
                present = (" " + term + " ") in low
            else:
                present = term in tokens
            if not present:
                continue

            modifier = 1.0
            # Inspect the two tokens before the term for negation / intensifiers.
            head = term.split()[0]
            if head in tokens:
                i = tokens.index(head)
                window = tokens[max(0, i - 2):i]
                if any(w in _NEGATIONS for w in window):
                    modifier *= -0.8
                for w in window:
                    if w in _INTENSIFIERS:
                        modifier *= _INTENSIFIERS[w]

            delta = weight * modifier * _HIT_POINTS
            raw[dimension] += delta
            matched.append({"dimension": dimension, "term": term, "delta": round(delta, 1)})

    dimensions = {
        d: round(max(-_MAX_PER_DIM, min(_MAX_PER_DIM, v)), 1)
        for d, v in raw.items()
        if abs(v) >= 0.5
    }
    return {"dimensions": dimensions, "matched": matched, "tokens": len(tokens)}
