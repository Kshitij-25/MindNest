"""Emotional-memory search (camelCase)."""
from __future__ import annotations

from fastapi import APIRouter, Depends, Query
from sqlalchemy.ext.asyncio import AsyncSession

from app.api.deps import get_current_user
from app.database import get_db
from app.models import User
from app.schemas.memory import MemorySearchOut
from app.services import memory_service

router = APIRouter(prefix="/memory", tags=["memory"])


@router.get("/search", response_model=MemorySearchOut)
async def search(
    q: str = Query(..., min_length=1, description="Free-text query"),
    top_k: int = Query(5, ge=1, le=20),
    db: AsyncSession = Depends(get_db),
    user: User = Depends(get_current_user),
):
    return await memory_service.search(db, user, q, top_k=top_k)
