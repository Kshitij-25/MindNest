"""Emotional-memory indexing.

Writes a higher-level ``Memory`` row over the vector ``Embedding`` store. One
entry point (:func:`index_memory`) is reused by journal analysis (and seeds /
future indexers) so the embedding + memory upsert lives in exactly one place.
Embeddings are optional: with the embedder disabled, the memory row is still
written (retrieval falls back to keyword scoring).
"""
from __future__ import annotations

from sqlalchemy import select

from app.ai.embeddings import embedder
from app.models import Embedding, Memory


async def index_memory(
    db,
    *,
    user_id: str,
    kind: str,
    ref_id: str,
    text: str,
    summary: str = "",
    source: str = "journal",
    journal_id: str | None = None,
) -> Memory:
    """Upsert the ``Memory`` for (kind, ref_id) and (if possible) its embedding.

    Does not commit — the caller owns the transaction.
    """
    text = (text or "").strip()
    emb_id = None
    vec = embedder.embed(text)
    if vec:
        emb = Embedding(
            user_id=user_id,
            source=source,
            journal_id=journal_id,
            text=text[:2000],
            model=embedder._model.__class__.__name__ if embedder._model else "",
            dim=len(vec),
            vector=vec,
        )
        db.add(emb)
        await db.flush()
        emb_id = emb.id

    res = await db.execute(
        select(Memory).where(Memory.kind == kind, Memory.ref_id == ref_id)
    )
    mem = res.scalar_one_or_none()
    if mem is None:
        mem = Memory(user_id=user_id, kind=kind, ref_id=ref_id)
        db.add(mem)
    mem.text = text[:2000]
    mem.summary = (summary or "")[:500]
    if emb_id:
        mem.embedding_id = emb_id
    return mem
