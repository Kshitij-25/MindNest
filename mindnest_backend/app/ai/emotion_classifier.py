"""Transformer emotion classifier (optional).

Wraps ``j-hartmann/emotion-english-distilroberta-base`` via HuggingFace
Transformers. The model is loaded lazily on first use and only if
(a) the feature is enabled in settings and (b) ``transformers`` + ``torch``
are importable. If anything is missing it reports ``available=False`` and
the pipeline simply skips this stage — no crash, no hard dependency.
"""
from __future__ import annotations

import logging

from app.config import settings

logger = logging.getLogger("mindnest.ai.emotion")


class EmotionClassifier:
    def __init__(self) -> None:
        self._pipe = None
        self._tried = False
        self._available = False

    @property
    def available(self) -> bool:
        if not self._tried:
            self._load()
        return self._available

    def _load(self) -> None:
        self._tried = True
        if not settings.ENABLE_TRANSFORMER_EMOTION:
            logger.info("Transformer emotion classifier disabled via settings.")
            return
        try:
            from transformers import pipeline  # type: ignore

            self._pipe = pipeline(
                "text-classification",
                model=settings.EMOTION_MODEL,
                top_k=None,          # return all label scores
                truncation=True,
            )
            self._available = True
            logger.info("Loaded emotion model: %s", settings.EMOTION_MODEL)
        except Exception as exc:  # pragma: no cover - depends on optional deps
            logger.warning(
                "Emotion classifier unavailable (%s). Falling back to rule-based.",
                exc.__class__.__name__,
            )
            self._available = False

    def classify(self, text: str) -> list[dict] | None:
        """Return ``[{"label": str, "score": float}, ...]`` sorted desc, or None."""
        text = (text or "").strip()
        if not text or not self.available:
            return None
        try:
            out = self._pipe(text[:512])  # type: ignore[misc]
            # transformers returns a list-of-lists when top_k=None
            scores = out[0] if out and isinstance(out[0], list) else out
            return sorted(scores, key=lambda d: d["score"], reverse=True)
        except Exception as exc:  # pragma: no cover
            logger.warning("Emotion classify failed: %s", exc)
            return None


# module-level singleton
emotion_classifier = EmotionClassifier()
