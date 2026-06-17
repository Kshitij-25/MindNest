"""AI → human support handoff endpoint.

Surfaces the referral engine's suggestion (with ranked professionals) so the
client can offer human support alongside the AI experience — e.g. after an AI
coach turn or on the insights screen. MVP 1 services are read, never modified.
"""
from __future__ import annotations

from fastapi import APIRouter, Depends, Query
from sqlalchemy.ext.asyncio import AsyncSession

from app.api.deps import get_current_user
from app.database import get_db
from app.models import User
from app.schemas.support import ReferralOut
from app.services import referral_service

router = APIRouter(prefix="/support", tags=["Marketplace"])


@router.get("/referral", response_model=ReferralOut)
async def referral(
    user_requested: bool = Query(
        False,
        alias="userRequested",
        description="Set when the user explicitly asks for human support.",
    ),
    db: AsyncSession = Depends(get_db),
    user: User = Depends(get_current_user),
):
    return await referral_service.referral(db, user, user_requested=user_requested)
