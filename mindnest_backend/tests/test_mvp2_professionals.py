"""MVP 2 — professional auth, verification, marketplace and matching.

These tests reuse the shared ``client`` fixture (fresh DB per test) from
``conftest.py`` and never touch MVP 1 behaviour.
"""
from __future__ import annotations

import pytest

API = "/api/v1"
ADMIN_TOKEN = "test-admin-token"


# ---- helpers -----------------------------------------------------------------


async def _register_user(client, email: str) -> str:
    await client.post(
        f"{API}/auth/register",
        json={"email": email, "password": "secret1", "display_name": "U"},
    )
    r = await client.post(
        f"{API}/auth/login", data={"username": email, "password": "secret1"}
    )
    return r.json()["access_token"]


async def _register_pro(client, email: str, **profile) -> dict:
    body = {"email": email, "password": "secret1", "name": "Dr Pro", **profile}
    await client.post(f"{API}/professional/auth/register", json=body)
    r = await client.post(
        f"{API}/professional/auth/login", data={"username": email, "password": "secret1"}
    )
    return r.json()


def _bearer(token: str) -> dict:
    return {"Authorization": f"Bearer {token}"}


async def _approve_pro(client, pro_token: str) -> None:
    """Submit a verification doc and approve it via the admin endpoint."""
    # ADMIN token must be active for require_admin to pass.
    from app.config import settings

    settings.ADMIN_API_TOKEN = ADMIN_TOKEN
    sub = await client.post(
        f"{API}/professional/verifications",
        headers=_bearer(pro_token),
        json={"documentType": "license", "documentUrl": "https://x/doc.pdf"},
    )
    vid = sub.json()["id"]
    r = await client.patch(
        f"{API}/professional/verifications/{vid}/review",
        headers={"X-Admin-Token": ADMIN_TOKEN},
        json={"status": "approved"},
    )
    assert r.status_code == 200, r.text
    assert r.json()["status"] == "approved"


# ---- tests -------------------------------------------------------------------


@pytest.mark.asyncio
async def test_pro_auth_is_isolated_from_user_auth(client):
    user_token = await _register_user(client, "u1@example.com")
    pro = await _register_pro(client, "p1@example.com")
    pro_token = pro["access_token"]

    # A professional token must NOT authenticate a user endpoint…
    r = await client.get(f"{API}/auth/me", headers=_bearer(pro_token))
    assert r.status_code == 401

    # …and a user token must NOT authenticate a professional endpoint.
    r = await client.get(f"{API}/professional/auth/me", headers=_bearer(user_token))
    assert r.status_code == 401

    # Each resolves correctly on its own side.
    r = await client.get(f"{API}/professional/auth/me", headers=_bearer(pro_token))
    assert r.status_code == 200
    assert r.json()["email"] == "p1@example.com"


@pytest.mark.asyncio
async def test_marketplace_only_shows_verified(client):
    user_token = await _register_user(client, "u2@example.com")
    pro = await _register_pro(
        client, "p2@example.com", specializations=["burnout", "stress"]
    )

    # Unverified → not listed.
    r = await client.get(f"{API}/professionals", headers=_bearer(user_token))
    assert r.status_code == 200
    assert r.json() == []

    await _approve_pro(client, pro["access_token"])

    r = await client.get(f"{API}/professionals", headers=_bearer(user_token))
    listed = r.json()
    assert len(listed) == 1
    assert listed[0]["verificationStatus"] == "approved"
    assert "burnout" in listed[0]["specializations"]


@pytest.mark.asyncio
async def test_matching_ranks_burnout_specialist_first(client):
    user_token = await _register_user(client, "u3@example.com")

    # A burnout-heavy emotional profile via onboarding.
    r = await client.post(
        f"{API}/onboarding",
        headers=_bearer(user_token),
        json={"mood": 1, "stress": 10, "sleep": 1, "anxiety": 3,
              "goals": ["manage work stress"], "focusAreas": ["career"]},
    )
    assert r.status_code == 200
    assert r.json()["derived"].get("burnout_risk", 0) > 0

    burnout_pro = await _register_pro(
        client, "burnout@example.com", specializations=["burnout", "stress"]
    )
    sleep_pro = await _register_pro(
        client, "relations@example.com", specializations=["relationships"]
    )
    await _approve_pro(client, burnout_pro["access_token"])
    await _approve_pro(client, sleep_pro["access_token"])

    r = await client.get(f"{API}/professionals/recommended", headers=_bearer(user_token))
    assert r.status_code == 200
    matches = r.json()
    assert len(matches) == 2
    # The burnout/stress specialist outranks the relationships one.
    top = matches[0]["professional"]
    assert "burnout" in top["specializations"]
    assert matches[0]["score"] > matches[1]["score"]
    assert matches[0]["reasons"]  # explainable
