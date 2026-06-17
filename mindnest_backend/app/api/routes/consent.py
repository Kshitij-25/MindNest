"""Data-sharing consent endpoints (user side).

Consent is never auto-granted: a user explicitly grants per-scope access to a
professional here, and can revoke any scope at any time.
"""
from __future__ import annotations

from fastapi import APIRouter, Depends, Query, status
from sqlalchemy.ext.asyncio import AsyncSession

from app.api.deps import get_current_user
from app.database import get_db
from app.models import User
from app.schemas.consent import ConsentGrant, ConsentOut
from app.services import consent_service

router = APIRouter(prefix="/consent", tags=["Marketplace"])


@router.get("", response_model=list[ConsentOut])
async def list_consent(
    db: AsyncSession = Depends(get_db),
    user: User = Depends(get_current_user),
):
    return [consent_service.to_out(r) for r in await consent_service.list_for_user(db, user)]


@router.post("", response_model=list[ConsentOut], status_code=status.HTTP_201_CREATED)
async def grant_consent(
    payload: ConsentGrant,
    db: AsyncSession = Depends(get_db),
    user: User = Depends(get_current_user),
):
    records = await consent_service.grant(db, user, payload.professional_id, payload.scopes)
    return [consent_service.to_out(r) for r in records]


@router.delete("", response_model=ConsentOut)
async def revoke_consent(
    professional_id: str = Query(alias="professionalId"),
    scope: str = Query(...),
    db: AsyncSession = Depends(get_db),
    user: User = Depends(get_current_user),
):
    return consent_service.to_out(
        await consent_service.revoke(db, user, professional_id, scope)
    )
