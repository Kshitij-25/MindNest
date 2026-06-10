"""Seed the questions table from the JSON question bank (idempotent)."""
from __future__ import annotations

from app.models import Question
from app.services.questionnaire_engine import get_bank

_META_KEYS = {"id", "text", "type", "dimension", "stage"}


async def seed_questions(db) -> int:
    bank = get_bank()
    for q in bank.all():
        payload = {k: v for k, v in q.items() if k not in _META_KEYS}
        await db.merge(Question(
            id=q["id"],
            text=q["text"],
            type=q["type"],
            dimension=q.get("dimension", "general"),
            stage=q.get("stage", "baseline"),
            is_active=True,
            payload=payload,
        ))
    await db.commit()
    return len(bank.all())
