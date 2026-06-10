"""Emotional memory: indexing (store) + semantic retrieval (retriever)."""
from app.ai.memory.retriever import search
from app.ai.memory.store import index_memory

__all__ = ["index_memory", "search"]
