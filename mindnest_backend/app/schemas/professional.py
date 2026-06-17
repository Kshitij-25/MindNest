"""Professional auth, profile, verification and dashboard schemas (camelCase)."""
from __future__ import annotations

from datetime import datetime
from typing import Any

from pydantic import Field

from app.schemas.auth import Email
from app.schemas.common import CamelModel


# ---- auth --------------------------------------------------------------------


class ProfessionalRegister(CamelModel):
    email: Email
    password: str = Field(min_length=6, max_length=128)
    name: str = Field(min_length=1, max_length=120)
    title: str | None = Field(default=None, max_length=160)
    specializations: list[str] = Field(default_factory=list)
    languages: list[str] = Field(default_factory=list)
    experience_years: int = Field(default=0, ge=0, le=80)
    bio: str = ""
    session_price: float = Field(default=0.0, ge=0)
    currency: str = "USD"
    timezone: str = "UTC"


# ---- profile -----------------------------------------------------------------


class ProfessionalUpdate(CamelModel):
    name: str | None = Field(default=None, max_length=120)
    photo: str | None = None
    title: str | None = Field(default=None, max_length=160)
    specializations: list[str] | None = None
    languages: list[str] | None = None
    experience_years: int | None = Field(default=None, ge=0, le=80)
    bio: str | None = None
    education: list[str] | None = None
    certifications: list[str] | None = None
    session_price: float | None = Field(default=None, ge=0)
    currency: str | None = None
    timezone: str | None = None


class ProfessionalOut(CamelModel):
    """Public marketplace card."""

    id: str
    name: str
    photo: str | None = None
    title: str | None = None
    specializations: list[str] = Field(default_factory=list)
    specialization_labels: list[str] = Field(default_factory=list)
    languages: list[str] = Field(default_factory=list)
    experience_years: int = 0
    bio: str = ""
    education: list[str] = Field(default_factory=list)
    certifications: list[str] = Field(default_factory=list)
    verification_status: str
    rating: float = 0.0
    review_count: int = 0
    session_price: float = 0.0
    currency: str = "USD"
    timezone: str = "UTC"
    created_at: datetime


class ProfessionalSelfOut(ProfessionalOut):
    """The professional's own view of their profile (adds private fields)."""

    email: str
    is_active: bool = True


# ---- verification ------------------------------------------------------------


class VerificationSubmit(CamelModel):
    document_type: str = Field(description="license | certification | identity")
    document_url: str
    note: str = ""


class VerificationOut(CamelModel):
    id: str
    professional_id: str
    document_type: str
    document_url: str
    note: str = ""
    status: str
    review_note: str = ""
    reviewed_at: datetime | None = None
    created_at: datetime


class VerificationReview(CamelModel):
    status: str = Field(description="approved | rejected")
    review_note: str = ""


# ---- dashboard ---------------------------------------------------------------


class DashboardOut(CamelModel):
    """Aggregate professional dashboard. Sub-sections are open maps so the
    service can enrich them without a schema migration."""

    profile: ProfessionalSelfOut
    availability: dict[str, Any] = Field(default_factory=dict)
    bookings: dict[str, Any] = Field(default_factory=dict)
    clients: dict[str, Any] = Field(default_factory=dict)
    reviews: dict[str, Any] = Field(default_factory=dict)
    analytics: dict[str, Any] = Field(default_factory=dict)
