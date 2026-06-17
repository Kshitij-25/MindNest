"""Marketplace endpoints (MVP 2): discover, search and AI-recommended pros.

``/professionals/recommended`` ranks via the matching engine using the current
user's emotional profile, burnout risk, goals and focus areas. Static paths are
declared before ``/{professional_id}`` so they aren't swallowed by it.
"""
from __future__ import annotations

from fastapi import APIRouter, Depends, Query
from sqlalchemy.ext.asyncio import AsyncSession

from app.api.deps import get_current_user
from app.database import get_db
from app.models import User
from app.schemas.availability import SlotOut
from app.schemas.booking import ReviewOut
from app.schemas.marketplace import MatchOut
from app.schemas.professional import ProfessionalOut
from app.services import (
    marketplace_service,
    professional_matching,
    professional_service,
    review_service,
)

router = APIRouter(prefix="/professionals", tags=["Marketplace"])


@router.get("", response_model=list[ProfessionalOut])
async def list_professionals(
    specialization: str | None = Query(None),
    language: str | None = Query(None),
    max_price: float | None = Query(None, alias="maxPrice", ge=0),
    min_rating: float | None = Query(None, alias="minRating", ge=0, le=5),
    limit: int = Query(50, ge=1, le=100),
    offset: int = Query(0, ge=0),
    db: AsyncSession = Depends(get_db),
    _: User = Depends(get_current_user),
):
    return await marketplace_service.list_professionals(
        db,
        specialization=specialization,
        language=language,
        max_price=max_price,
        min_rating=min_rating,
        limit=limit,
        offset=offset,
    )


@router.get("/recommended", response_model=list[MatchOut])
async def recommended(
    limit: int = Query(5, ge=1, le=20),
    db: AsyncSession = Depends(get_db),
    user: User = Depends(get_current_user),
):
    """Professionals ranked for the current user's emotional signals."""
    return await professional_matching.recommended(db, user, limit=limit)


@router.get("/search", response_model=list[ProfessionalOut])
async def search(
    q: str = Query("", description="match name or bio"),
    specialization: str | None = Query(None),
    language: str | None = Query(None),
    max_price: float | None = Query(None, alias="maxPrice", ge=0),
    min_rating: float | None = Query(None, alias="minRating", ge=0, le=5),
    limit: int = Query(50, ge=1, le=100),
    offset: int = Query(0, ge=0),
    db: AsyncSession = Depends(get_db),
    _: User = Depends(get_current_user),
):
    return await marketplace_service.list_professionals(
        db,
        query=q or None,
        specialization=specialization,
        language=language,
        max_price=max_price,
        min_rating=min_rating,
        limit=limit,
        offset=offset,
    )


@router.get("/{professional_id}", response_model=ProfessionalOut)
async def get_professional(
    professional_id: str,
    db: AsyncSession = Depends(get_db),
    _: User = Depends(get_current_user),
):
    return await marketplace_service.get_detail(db, professional_id)


@router.get("/{professional_id}/availability", response_model=list[SlotOut])
async def professional_availability(
    professional_id: str,
    db: AsyncSession = Depends(get_db),
    _: User = Depends(get_current_user),
):
    return await marketplace_service.availability(db, professional_id)


@router.get("/{professional_id}/reviews", response_model=list[ReviewOut])
async def professional_reviews(
    professional_id: str,
    db: AsyncSession = Depends(get_db),
    _: User = Depends(get_current_user),
):
    await professional_service.get(db, professional_id)  # 404 if unknown
    return [review_service.to_out(r) for r in await review_service.list_for_professional(db, professional_id)]
