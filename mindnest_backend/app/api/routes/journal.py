"""Journaling endpoints (camelCase). Writes return immediately; AI analysis
runs in the background and is polled at ``/entries/{id}/analysis``."""
from __future__ import annotations

from fastapi import APIRouter, BackgroundTasks, Depends, Query, Response, status
from sqlalchemy.ext.asyncio import AsyncSession

from app.api.deps import get_current_user
from app.database import get_db
from app.models import User
from app.schemas.journal import (
    JournalAnalysisOut,
    JournalCreate,
    JournalOut,
    JournalPromptsOut,
    JournalUpdate,
)
from app.services import journal_service

router = APIRouter(prefix="/journal", tags=["journal"])


@router.get("/prompts", response_model=JournalPromptsOut)
async def writing_prompts(
    kind: str | None = Query(None, description="guided | gratitude | reflection | free"),
    _: User = Depends(get_current_user),
):
    return journal_service.prompts_for(kind)


@router.get("/entries", response_model=list[JournalOut])
async def list_entries(
    limit: int = Query(50, ge=1, le=200),
    offset: int = Query(0, ge=0),
    include_drafts: bool = Query(False),
    db: AsyncSession = Depends(get_db),
    user: User = Depends(get_current_user),
):
    return await journal_service.list_entries(
        db, user, limit=limit, offset=offset, include_drafts=include_drafts
    )


@router.post("/entries", response_model=JournalOut, status_code=status.HTTP_201_CREATED)
async def create_entry(
    payload: JournalCreate,
    background: BackgroundTasks,
    db: AsyncSession = Depends(get_db),
    user: User = Depends(get_current_user),
):
    """Create an entry; AI analysis is scheduled in the background."""
    return await journal_service.create(db, user, payload, background)


@router.get("/entries/{journal_id}", response_model=JournalOut)
async def get_entry(
    journal_id: str,
    db: AsyncSession = Depends(get_db),
    user: User = Depends(get_current_user),
):
    return await journal_service.get_entry(db, user, journal_id)


@router.patch("/entries/{journal_id}", response_model=JournalOut)
async def update_entry(
    journal_id: str,
    payload: JournalUpdate,
    background: BackgroundTasks,
    db: AsyncSession = Depends(get_db),
    user: User = Depends(get_current_user),
):
    return await journal_service.update(db, user, journal_id, payload, background)


@router.delete("/entries/{journal_id}", status_code=status.HTTP_204_NO_CONTENT)
async def delete_entry(
    journal_id: str,
    db: AsyncSession = Depends(get_db),
    user: User = Depends(get_current_user),
):
    await journal_service.delete(db, user, journal_id)
    return Response(status_code=status.HTTP_204_NO_CONTENT)


@router.get("/entries/{journal_id}/analysis", response_model=JournalAnalysisOut)
async def get_analysis(
    journal_id: str,
    db: AsyncSession = Depends(get_db),
    user: User = Depends(get_current_user),
):
    """Poll the analysis. ``status``/``ready`` reflect the lifecycle."""
    return await journal_service.get_analysis(db, user, journal_id)
