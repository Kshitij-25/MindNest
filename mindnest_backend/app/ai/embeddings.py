"""Sentence-embedding layer (optional).

Wraps ``sentence-transformers/all-MiniLM-L6-v2`` for the embedding-
similarity memory. Lazy-loaded and fully optional, exactly like the
emotion classifier. Cosine similarity itself is pure-Python (see
``cosine_similarity``) so the *comparison* never needs numpy even when
vectors were produced elsewhere.
"""
from __future__ import annotations

import logging
import math

from app.config import settings

logger = logging.getLogger("mindnest.ai.embeddings")


class Embedder:
    def __init__(self) -> None:
        self._model = None
        self._tried = False
        self._available = False
        self._dim = 0

    @property
    def available(self) -> bool:
        if not self._tried:
            self._load()
        return self._available

    @property
    def dim(self) -> int:
        _ = self.available
        return self._dim

    def _load(self) -> None:
        self._tried = True
        if not settings.ENABLE_EMBEDDINGS:
            logger.info("Embeddings disabled via settings.")
            return
        try:
            from sentence_transformers import SentenceTransformer  # type: ignore

            self._model = SentenceTransformer(settings.EMBEDDING_MODEL)
            # sentence-transformers >=5 renamed this to get_embedding_dimension();
            # prefer the new name, fall back for older versions.
            get_dim = getattr(self._model, "get_embedding_dimension", None) or \
                self._model.get_sentence_embedding_dimension
            self._dim = int(get_dim())
            self._available = True
            logger.info("Loaded embedding model: %s (dim=%d)",
                        settings.EMBEDDING_MODEL, self._dim)
        except Exception as exc:  # pragma: no cover - optional deps
            logger.warning(
                "Embedder unavailable (%s). Similarity memory disabled.",
                exc.__class__.__name__,
            )
            self._available = False

    def embed(self, text: str) -> list[float] | None:
        text = (text or "").strip()
        if not text or not self.available:
            return None
        try:
            vec = self._model.encode(text, normalize_embeddings=True)  # type: ignore
            return [float(x) for x in vec]
        except Exception as exc:  # pragma: no cover
            logger.warning("Embedding failed: %s", exc)
            return None


def cosine_similarity(a: list[float], b: list[float]) -> float:
    """Pure-Python cosine similarity. Returns 0.0 for empty/zero vectors."""
    if not a or not b or len(a) != len(b):
        return 0.0
    dot = sum(x * y for x, y in zip(a, b))
    na = math.sqrt(sum(x * x for x in a))
    nb = math.sqrt(sum(y * y for y in b))
    if na == 0 or nb == 0:
        return 0.0
    return dot / (na * nb)


embedder = Embedder()
