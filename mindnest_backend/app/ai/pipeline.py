"""Hybrid text→mood analysis pipeline.

Fuses two complementary signals for any piece of free text:

  1. rule-based lexicon  (always on, transparent)
  2. transformer emotion classifier  (optional, nuanced)

into a single set of dimension deltas on the shared 0..100 scale. The
embedding and LLM layers are orchestrated elsewhere (at assessment
completion) — this module is the per-answer text analyzer.
"""
from __future__ import annotations

from collections import defaultdict

from app.ai import rule_based
from app.ai.embeddings import embedder
from app.ai.emotion_classifier import emotion_classifier
from app.ai.llm import ollama
from app.config import settings
from app.core.dimensions import EMOTION_LABEL_TO_DIMENSIONS

# How strongly each source contributes (rule-based is already in points).
RULE_BASED_GAIN = 1.0
TRANSFORMER_GAIN = 42.0
_CLAMP = 55.0


def analyze_text(text: str, focus: list[str] | None = None) -> dict:
    """Analyze free text into dimension deltas + provenance.

    Returns::

        {
          "dimensions": {dim: delta, ...},
          "rule_based": {...},
          "transformer": [{"label","score"}, ...] | None,
          "top_emotion": {"label","score"} | None,
          "sources": ["rule_based", "transformer"?],
        }
    """
    text = (text or "").strip()
    deltas: dict[str, float] = defaultdict(float)
    sources: list[str] = []

    rb = rule_based.analyze(text)
    if rb["dimensions"]:
        sources.append("rule_based")
    for dim, delta in rb["dimensions"].items():
        deltas[dim] += delta * RULE_BASED_GAIN

    transformer = emotion_classifier.classify(text) if text else None
    top_emotion = None
    if transformer:
        sources.append("transformer")
        top_emotion = transformer[0]
        for item in transformer:
            label, score = item["label"].lower(), float(item["score"])
            for dim, weight in EMOTION_LABEL_TO_DIMENSIONS.get(label, []):
                deltas[dim] += score * weight * TRANSFORMER_GAIN

    # Light boost for dimensions the question specifically targets.
    if focus:
        for dim in list(deltas):
            if dim in focus:
                deltas[dim] *= 1.1

    clamped = {
        d: round(max(-_CLAMP, min(_CLAMP, v)), 1)
        for d, v in deltas.items()
        if abs(v) >= 0.5
    }
    return {
        "dimensions": clamped,
        "rule_based": rb,
        "transformer": transformer,
        "top_emotion": top_emotion,
        "sources": sources,
    }


def pipeline_status() -> dict:
    """Report layer availability without forcing heavy model loads."""
    return {
        "rule_based": True,
        "transformer_emotion": {
            "enabled": settings.ENABLE_TRANSFORMER_EMOTION,
            "loaded": emotion_classifier._tried and emotion_classifier._available,
            "model": settings.EMOTION_MODEL,
        },
        "embeddings": {
            "enabled": settings.ENABLE_EMBEDDINGS,
            "loaded": embedder._tried and embedder._available,
            "model": settings.EMBEDDING_MODEL,
        },
        "llm": {
            "enabled": settings.ENABLE_LLM,
            "model": settings.OLLAMA_MODEL,
            "base_url": settings.OLLAMA_BASE_URL,
        },
    }


async def llm_available() -> bool:
    return await ollama.health()
