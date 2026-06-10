"""Journaling CRUD + non-blocking AI analysis.

Writes return immediately with ``analysisStatus: "pending"``; a FastAPI
``BackgroundTasks`` job (``run_analysis``) runs the journaling pipeline on its
own DB session, writes the ``journal_analysis`` row (+ an ``Embedding`` and a
``Memory`` index entry), and flips the status to ``ready`` (or ``failed``).
The ``enable_journal_ai`` feature flag is respected: when off, no job is
scheduled and the entry's status is ``disabled``.
"""
from __future__ import annotations

import logging

from fastapi import BackgroundTasks, HTTPException, status
from sqlalchemy import select

from app.ai.journaling import analyzer, prompts
from app.ai.memory import store as memory_store
from app.core.feature_flags import flag_enabled
from app.core.time_format import clock_label, day_label, relative_time
from app.database import AsyncSessionLocal
from app.models import (
    Journal,
    JournalAnalysis,
    JournalAnalysisStatus,
    User,
)

logger = logging.getLogger("mindnest.journal")


# ---- serialization -----------------------------------------------------------


def to_out(j: Journal) -> dict:
    return {
        "id": j.id,
        "kind": j.kind,
        "prompt": j.prompt,
        "mood": j.mood,
        "title": j.title or "",
        "body": j.body or "",
        "tags": j.tags or [],
        "draft": j.draft,
        "analysis_status": j.analysis_status,
        "created_at": j.created_at,
        "updated_at": j.updated_at,
        "day_label": day_label(j.created_at),
        "clock_label": clock_label(j.created_at),
        "relative_time": relative_time(j.created_at),
    }


def analysis_to_out(a: JournalAnalysis) -> dict:
    return {
        "journal_id": a.journal_id,
        "emotion": a.emotion,
        "dimensions": a.dimensions or {},
        "summary": a.summary or "",
        "topics": a.topics or [],
        "themes": a.themes or [],
        "stressors": a.stressors or [],
        "wins": a.wins or [],
        "concerns": a.concerns or [],
        "suggestions": a.suggestions or [],
        "sources": a.sources or [],
        "model": a.model or "",
        "created_at": a.created_at,
    }


# ---- reads -------------------------------------------------------------------


async def _owned(db, user: User, journal_id: str) -> Journal:
    res = await db.execute(select(Journal).where(Journal.id == journal_id))
    j = res.scalar_one_or_none()
    if j is None or j.user_id != user.id:
        raise HTTPException(status.HTTP_404_NOT_FOUND, "Journal entry not found")
    return j


async def list_entries(db, user: User, *, limit: int = 50, offset: int = 0,
                       include_drafts: bool = False) -> list[dict]:
    stmt = select(Journal).where(Journal.user_id == user.id)
    if not include_drafts:
        stmt = stmt.where(Journal.draft.is_(False))
    stmt = stmt.order_by(Journal.created_at.desc()).limit(limit).offset(offset)
    res = await db.execute(stmt)
    return [to_out(j) for j in res.scalars().all()]


async def get_entry(db, user: User, journal_id: str) -> dict:
    return to_out(await _owned(db, user, journal_id))


async def get_analysis(db, user: User, journal_id: str) -> dict:
    j = await _owned(db, user, journal_id)
    res = await db.execute(
        select(JournalAnalysis).where(JournalAnalysis.journal_id == j.id)
    )
    a = res.scalar_one_or_none()
    if a is None:
        # No row yet — report the entry's lifecycle state instead of 404.
        return {
            "journal_id": j.id,
            "status": j.analysis_status,
            "ready": False,
        }
    out = analysis_to_out(a)
    out["status"] = j.analysis_status
    out["ready"] = j.analysis_status == JournalAnalysisStatus.READY
    return out


def prompts_for(kind: str | None) -> dict:
    return {"kind": kind or "mixed", "prompts": prompts.prompts_for(kind)}


# ---- writes ------------------------------------------------------------------


def _initial_status(user: User, *, draft: bool, body: str) -> str:
    if draft or not (body or "").strip():
        return JournalAnalysisStatus.DISABLED
    if not flag_enabled(user.settings, "enable_journal_ai"):
        return JournalAnalysisStatus.DISABLED
    return JournalAnalysisStatus.PENDING


async def create(db, user: User, payload, background: BackgroundTasks) -> dict:
    body = payload.body or ""
    st = _initial_status(user, draft=payload.draft, body=body)
    journal = Journal(
        user_id=user.id,
        kind=payload.kind,
        prompt=payload.prompt,
        mood=payload.mood,
        title=payload.title or "",
        body=body,
        tags=payload.tags or [],
        draft=payload.draft,
        analysis_status=st,
    )
    db.add(journal)
    await db.commit()
    await db.refresh(journal)

    if st == JournalAnalysisStatus.PENDING:
        background.add_task(run_analysis, journal.id, user.id, body)
    return to_out(journal)


async def update(db, user: User, journal_id: str, payload, background: BackgroundTasks) -> dict:
    j = await _owned(db, user, journal_id)
    fields = payload.model_dump(exclude_unset=True, by_alias=False)
    body_changed = "body" in fields and fields["body"] != j.body

    for key in ("kind", "prompt", "mood", "title", "body", "tags", "draft"):
        if key in fields and fields[key] is not None:
            setattr(j, key, fields[key])

    # Re-analyse when the text changed (and the entry is analysable now).
    reschedule = False
    if body_changed or ("draft" in fields):
        st = _initial_status(user, draft=j.draft, body=j.body or "")
        j.analysis_status = st
        reschedule = st == JournalAnalysisStatus.PENDING

    await db.commit()
    await db.refresh(j)

    if reschedule:
        background.add_task(run_analysis, j.id, user.id, j.body or "")
    return to_out(j)


async def delete(db, user: User, journal_id: str) -> None:
    j = await _owned(db, user, journal_id)
    await db.delete(j)
    await db.commit()


# ---- background analysis -----------------------------------------------------


async def run_analysis(journal_id: str, user_id: str, text: str) -> None:
    """Background job: analyse an entry and persist the result. Never raises."""
    async with AsyncSessionLocal() as db:
        try:
            res = await db.execute(select(Journal).where(Journal.id == journal_id))
            j = res.scalar_one_or_none()
            if j is None:
                return

            result = await analyzer.analyze(text)

            # Upsert the analysis row.
            ex = await db.execute(
                select(JournalAnalysis).where(JournalAnalysis.journal_id == journal_id)
            )
            a = ex.scalar_one_or_none()
            if a is None:
                a = JournalAnalysis(journal_id=journal_id, user_id=user_id)
                db.add(a)
            a.emotion = result["emotion"]
            a.dimensions = result["dimensions"]
            a.summary = result["summary"]
            a.topics = result["topics"]
            a.themes = result["themes"]
            a.stressors = result["stressors"]
            a.wins = result["wins"]
            a.concerns = result["concerns"]
            a.suggestions = result["suggestions"]
            a.sources = result["sources"]
            a.model = result["model"]

            # Emotional-memory index (+ embedding when available).
            await memory_store.index_memory(
                db,
                user_id=user_id,
                kind="journal",
                ref_id=journal_id,
                text=text,
                summary=result["summary"],
                source="journal",
                journal_id=journal_id,
            )

            j.analysis_status = JournalAnalysisStatus.READY
            await db.commit()
        except Exception:  # pragma: no cover - defensive
            logger.exception("Journal analysis failed for %s", journal_id)
            await db.rollback()
            try:
                res = await db.execute(select(Journal).where(Journal.id == journal_id))
                j = res.scalar_one_or_none()
                if j is not None:
                    j.analysis_status = JournalAnalysisStatus.FAILED
                    await db.commit()
            except Exception:
                await db.rollback()
