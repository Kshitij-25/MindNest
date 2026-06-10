"""Onboarding intake → initial emotional baseline (camelCase)."""
from __future__ import annotations

from fastapi import APIRouter, Depends
from sqlalchemy.ext.asyncio import AsyncSession

from app.api.deps import get_current_user
from app.database import get_db
from app.models import User
from app.schemas.onboarding import (
    OnboardingRequest,
    OnboardingResultOut,
    OnboardingStatusOut,
)
from app.services import onboarding_service

router = APIRouter(prefix="/onboarding", tags=["onboarding"])


@router.get("/status", response_model=OnboardingStatusOut)
async def onboarding_status(
    db: AsyncSession = Depends(get_db),
    user: User = Depends(get_current_user),
):
    """Whether the user has completed onboarding (drives the first-run flow)."""
    return await onboarding_service.status(db, user)


@router.post("", response_model=OnboardingResultOut)
async def submit_onboarding(
    payload: OnboardingRequest,
    db: AsyncSession = Depends(get_db),
    user: User = Depends(get_current_user),
):
    """Seed the adaptive engine from the intake; returns the initial profile."""
    return await onboarding_service.submit(db, user, payload)
