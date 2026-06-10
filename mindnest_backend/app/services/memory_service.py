"""Emotional-memory search (foundation).

Thin service over the retriever — indexing happens at write time (journal
analysis, seeds). Used by ``GET /memory/search`` and by the AI coach for
grounding.
"""
from __future__ import annotations

from app.ai.memory import retriever
from app.models import User


async def search(db, user: User, query: str, *, top_k: int = 5) -> dict:
    results = await retriever.search(db, user.id, query, top_k=top_k)
    return {"query": query, "results": results}
