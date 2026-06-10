"""Camel-cased account schemas: profile, settings, feature flags, tokens."""
from __future__ import annotations

from datetime import datetime

from pydantic import Field

from app.schemas.common import CamelModel


class TokenPair(CamelModel):
    access_token: str
    refresh_token: str
    token_type: str = "bearer"
    expires_in_minutes: int


class RefreshRequest(CamelModel):
    refresh_token: str


class ForgotPasswordRequest(CamelModel):
    email: str


class ActivityRecord(CamelModel):
    icon: str
    value: str
    label: str
    color_key: str


class ProfileOut(CamelModel):
    """The rich profile shape the Flutter profile screen renders."""

    id: str
    name: str
    email: str
    avatar_url: str | None = None
    about: str | None = None
    phone: str | None = None
    onboarded: bool = False
    check_ins: str = "0"
    entries: str = "0"
    streak: str = "0"
    week_activity: list[ActivityRecord] = Field(default_factory=list)
    mood_week: list[int] = Field(default_factory=list)


class ProfileUpdate(CamelModel):
    name: str | None = None
    avatar_url: str | None = None
    about: str | None = None
    phone: str | None = None


class SettingsOut(CamelModel):
    feature_flags: dict[str, bool]
    theme: str = "system"


class SettingsUpdate(CamelModel):
    feature_flags: dict[str, bool] | None = None
    theme: str | None = None


class FlagInfo(CamelModel):
    key: str
    value: bool
    default: bool


class FlagCatalog(CamelModel):
    flags: list[FlagInfo]
