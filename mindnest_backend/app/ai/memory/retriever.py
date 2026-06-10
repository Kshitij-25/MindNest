"""Semantic (or keyword-fallback) retrieval over the emotional-memory index.

Cosine similarity over stored embeddings when the embedder is available;
otherwise a transparent keyword-overlap score so search still works fully
offline. pgvector-swappable: only this module knows how vectors are compared.
"""
from __future__ import annotations

import re

from sqlalchemy import select

from app.ai.embeddings import cosine_similarity, embedder
from app.models import Embedding, Memory

_TOKEN_RE = re.compile(r"[a-z']+")


def _keyword_score(query: str, text: str) -> float:
    q = set(_TOKEN_RE.findall((query or "").lower()))
    if not q:
        return 0.0
    t = set(_TOKEN_RE.findall((text or "").lower()))
    if not t:
        return 0.0
    return len(q & t) / len(q)


def _snippet(text: str, *, limit: int = 180) -> str:
    text = (text or "").strip().replace("\n", " ")
    return text if len(text) <= limit else text[: limit - 1].rstrip() + "…"


async def search(db, user_id: str, query: str, *, top_k: int = 5) -> list[dict]:
    res = await db.execute(select(Memory).where(Memory.user_id == user_id))
    memories = list(res.scalars().all())
    if not memories:
        return []

    qvec = embedder.embed(query)
    emb_map: dict[str, Embedding] = {}
    if qvec:
        ids = [m.embedding_id for m in memories if m.embedding_id]
        if ids:
            er = await db.execute(select(Embedding).where(Embedding.id.in_(ids)))
            emb_map = {e.id: e for e in er.scalars().all()}

    scored: list[tuple[float, Memory]] = []
    for m in memories:
        if qvec and m.embedding_id in emb_map:
            sim = cosine_similarity(qvec, emb_map[m.embedding_id].vector or [])
        else:
            sim = _keyword_score(query, f"{m.summary} {m.text}")
        if sim > 0:
            scored.append((sim, m))

    scored.sort(key=lambda p: p[0], reverse=True)
    return [
        {
            "id": m.id,
            "kind": m.kind,
            "ref_id": m.ref_id,
            "summary": m.summary or "",
            "snippet": _snippet(m.text or m.summary),
            "score": round(float(sim), 3),
            "created_at": m.created_at,
        }
        for sim, m in scored[:top_k]
    ]
