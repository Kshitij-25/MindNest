"""MindNest FastAPI application."""
from __future__ import annotations

import logging
from contextlib import asynccontextmanager

from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

from app import __version__
from app.api.exception_handlers import register_exception_handlers
from app.api.router import api_router
from app.config import settings
from app.database import AsyncSessionLocal, init_db
from app.services.demo_seed import seed_demo_content
from app.services.seed import seed_questions

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger("mindnest")

DESCRIPTION = """
**MindNest** is a local-first, offline-capable adaptive mood intelligence engine.

* Adaptive questionnaire that branches on your answers
* Hybrid mood analysis: rule-based + transformer + embeddings + local LLM
* Emotional trends, drift and burnout progression over time
* 100% open-source models, no paid APIs — runs on a normal laptop

_Not a medical device. MindNest does not diagnose and is not a substitute
for professional care._
"""


@asynccontextmanager
async def lifespan(app: FastAPI):
    await init_db()
    async with AsyncSessionLocal() as db:
        count = await seed_questions(db)
        if settings.SEED_DEMO_CONTENT:
            await seed_demo_content(db)
    logger.info("MindNest ready — %d questions seeded.", count)
    yield


app = FastAPI(
    title=settings.APP_NAME,
    version=__version__,
    description=DESCRIPTION,
    lifespan=lifespan,
)

# CORS — browsers forbid wildcard origins together with credentials, so we
# only enable credentials when explicit origins are configured.
_wildcard = settings.cors_origins_list == ["*"]
app.add_middleware(
    CORSMiddleware,
    allow_origins=settings.cors_origins_list,
    allow_credentials=not _wildcard,
    allow_methods=["*"],
    allow_headers=["*"],
)

register_exception_handlers(app)

app.include_router(api_router, prefix=settings.API_PREFIX)


@app.get("/", tags=["system"])
async def root():
    return {
        "app": settings.APP_NAME,
        "version": __version__,
        "docs": "/docs",
        "api_prefix": settings.API_PREFIX,
        "message": "Welcome to MindNest 🧠 — local-first mood intelligence.",
    }
