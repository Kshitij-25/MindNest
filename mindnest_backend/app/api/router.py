"""Aggregate API router."""
from __future__ import annotations

from fastapi import APIRouter

from app.api.routes import (
    account,
    analytics,
    assessment,
    auth,
    coach,
    dashboard,
    habits,
    insights,
    journal,
    library,
    memory,
    mood,
    notifications,
    onboarding,
    profile,
    recommendations,
    reports,
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
