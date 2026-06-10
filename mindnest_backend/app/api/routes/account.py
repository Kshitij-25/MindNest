"""Profile + settings + feature flags (camelCase)."""
from __future__ import annotations

from fastapi import APIRouter, Depends
from sqlalchemy.ext.asyncio import AsyncSession

from app.api.deps import get_current_user
from app.database import get_db
from app.models import User
from app.schemas.account import (
    FlagCatalog,
    ProfileOut,
    ProfileUpdate,
    SettingsOut,
    SettingsUpdate,
)
from app.services import account_service

router = APIRouter(tags=["account"])


@router.get("/profile", response_model=ProfileOut)
async def get_profile(
    db: AsyncSession = Depends(get_db),
    user: User = Depends(get_current_user),
):
    return await account_service.profile(db, user)


@router.patch("/profile", response_model=ProfileOut)
async def patch_profile(
    payload: ProfileUpdate,
    db: AsyncSession = Depends(get_db),
    user: User = Depends(get_current_user),
):
    return await account_service.update_profile(db, user, payload)


@router.get("/settings", response_model=SettingsOut)
async def get_settings(user: User = Depends(get_current_user)):
    return account_service.get_settings(user)


@router.patch("/settings", response_model=SettingsOut)
async def patch_settings(
    payload: SettingsUpdate,
    db: AsyncSession = Depends(get_db),
    user: User = Depends(get_current_user),
):
    return await account_service.update_settings(db, user, payload)


@router.get("/settings/flags", response_model=FlagCatalog)
async def get_flags(user: User = Depends(get_current_user)):
    return account_service.flag_catalog(user)
