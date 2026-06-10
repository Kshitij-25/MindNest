"""Health and AI-status endpoints."""
from __future__ import annotations

from fastapi import APIRouter

from app.ai import pipeline
from app.config import settings

router = APIRouter(tags=["system"])


@router.get("/health")
async def health():
    return {"status": "ok", "app": settings.APP_NAME, "env": settings.ENV}


@router.get("/ai/status")
async def ai_status():
    """Which AI layers are configured / loaded, plus a live Ollama check.

    Does not force the heavy models to load — it only reports current state.
    """
    status_payload = pipeline.pipeline_status()
    status_payload["llm"]["reachable"] = await pipeline.llm_available()
    return status_payload
