"""Aggregate API router."""
from __future__ import annotations

from fastapi import APIRouter

from app.api.routes import (
    account,
    analytics,
    assessment,
    auth,
    bookings,
    coach,
    community,
    consent,
    dashboard,
    habits,
    insights,
    journal,
    library,
    marketplace,
    memory,
    messaging,
    mood,
    notifications,
    onboarding,
    professional_auth,
    professionals,
    profile,
    programs,
    recommendations,
    reports,
    support,
    system,
)

api_router = APIRouter()
api_router.include_router(system.router)
api_router.include_router(auth.router)
api_router.include_router(account.router)
api_router.include_router(onboarding.router)
api_router.include_router(assessment.router)
api_router.include_router(mood.router)
api_router.include_router(journal.router)
api_router.include_router(library.router)
api_router.include_router(habits.router)
api_router.include_router(recommendations.router)
api_router.include_router(insights.router)
api_router.include_router(analytics.router)
api_router.include_router(reports.router)
api_router.include_router(memory.router)
api_router.include_router(coach.router)
api_router.include_router(notifications.router)
api_router.include_router(dashboard.router)
api_router.include_router(profile.router)

# ---- MVP 2: AI + Human (professional support, marketplace, bookings) ----
api_router.include_router(professional_auth.router)
api_router.include_router(professionals.router)
api_router.include_router(marketplace.router)
api_router.include_router(bookings.router)
api_router.include_router(consent.router)
api_router.include_router(support.router)
api_router.include_router(messaging.router)
api_router.include_router(community.router)
api_router.include_router(programs.router)
