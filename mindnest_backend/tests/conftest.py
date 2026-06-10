"""Shared pytest fixtures.

A throwaway SQLite DB with the optional AI layers disabled for determinism
(rule-based scoring is always on). Tables are dropped + recreated per test so
each test is isolated; questions are seeded so assessment templates work.
"""
from __future__ import annotations

import os

# Must be set before app.config builds its settings singleton.
os.environ.setdefault("ENABLE_TRANSFORMER_EMOTION", "False")
os.environ.setdefault("ENABLE_EMBEDDINGS", "False")
os.environ.setdefault("ENABLE_LLM", "False")
os.environ.setdefault("SEED_DEMO_CONTENT", "False")
os.environ.setdefault("DATABASE_URL", "sqlite+aiosqlite:///./_pytest.db")

import pytest_asyncio  # noqa: E402
from httpx import ASGITransport, AsyncClient  # noqa: E402


@pytest_asyncio.fixture
async def client():
    from app import models  # noqa: F401  (register models)
    from app.database import Base, engine
    from app.main import app
    from app.services.seed import seed_questions
    from app.database import AsyncSessionLocal

    async with engine.begin() as conn:
        await conn.run_sync(Base.metadata.drop_all)
        await conn.run_sync(Base.metadata.create_all)
    async with AsyncSessionLocal() as db:
        await seed_questions(db)

    transport = ASGITransport(app=app)
    async with AsyncClient(transport=transport, base_url="http://test") as c:
        yield c


async def _register_login(client: AsyncClient, email: str, password: str = "secret1") -> str:
    await client.post(
        "/api/v1/auth/register",
        json={"email": email, "password": password, "display_name": "Test"},
    )
    r = await client.post(
        "/api/v1/auth/login", data={"username": email, "password": password}
    )
    return r.json()["access_token"]


@pytest_asyncio.fixture
async def auth(client):
    """An authenticated client (Authorization header set)."""
    token = await _register_login(client, "test@example.com")
    client.headers.update({"Authorization": f"Bearer {token}"})
    return client
