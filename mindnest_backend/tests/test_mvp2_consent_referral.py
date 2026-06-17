"""MVP 2 — consent gating + the AI→human referral (handoff) engine."""
from __future__ import annotations

import pytest

API = "/api/v1"
ADMIN_TOKEN = "test-admin-token"


def _bearer(token: str) -> dict:
    return {"Authorization": f"Bearer {token}"}


async def _register_user(client, email: str) -> tuple[str, str]:
    await client.post(
        f"{API}/auth/register",
        json={"email": email, "password": "secret1", "display_name": "U"},
    )
    login = await client.post(
        f"{API}/auth/login", data={"username": email, "password": "secret1"}
    )
    token = login.json()["access_token"]
    me = await client.get(f"{API}/auth/me", headers=_bearer(token))
    return token, me.json()["id"]


async def _register_approved_pro(client, email: str) -> dict:
    from app.config import settings

    settings.ADMIN_API_TOKEN = ADMIN_TOKEN
    await client.post(
        f"{API}/professional/auth/register",
        json={"email": email, "password": "secret1", "name": "Dr Pro",
              "specializations": ["burnout", "stress"]},
    )
    login = await client.post(
        f"{API}/professional/auth/login",
        data={"username": email, "password": "secret1"},
    )
    pro_token = login.json()["access_token"]
    pro_id = (await client.get(
        f"{API}/professional/auth/me", headers=_bearer(pro_token)
    )).json()["id"]
    sub = await client.post(
        f"{API}/professional/verifications",
        headers=_bearer(pro_token),
        json={"documentType": "license", "documentUrl": "https://x/d.pdf"},
    )
    await client.patch(
        f"{API}/professional/verifications/{sub.json()['id']}/review",
        headers={"X-Admin-Token": ADMIN_TOKEN},
        json={"status": "approved"},
    )
    return {"token": pro_token, "id": pro_id}


# ---- referral ----------------------------------------------------------------


@pytest.mark.asyncio
async def test_referral_suggests_on_high_burnout_without_diagnosing(client):
    user_token, _ = await _register_user(client, "ru@example.com")
    await _register_approved_pro(client, "rp@example.com")

    await client.post(
        f"{API}/onboarding",
        headers=_bearer(user_token),
        json={"mood": 1, "stress": 10, "sleep": 1, "anxiety": 3,
              "goals": [], "focusAreas": []},
    )

    r = await client.get(f"{API}/support/referral", headers=_bearer(user_token))
    assert r.status_code == 200
    body = r.json()
    assert body["shouldSuggest"] is True
    assert body["severity"] in ("moderate", "high")
    assert body["reasons"]
    assert len(body["professionals"]) >= 1
    # Never diagnoses / claims medical certainty.
    blob = (body["message"] + " " + body["disclaimer"]).lower()
    assert "diagnos" in blob  # appears only as a *disclaimer* of diagnosis
    assert "not a medical" in blob or "isn't a diagnosis" in blob
    for term in ("you have", "disorder", "diagnosed with"):
        assert term not in blob


@pytest.mark.asyncio
async def test_referral_quiet_when_no_signals(client):
    user_token, _ = await _register_user(client, "calm@example.com")
    r = await client.get(f"{API}/support/referral", headers=_bearer(user_token))
    assert r.status_code == 200
    assert r.json()["shouldSuggest"] is False
    assert r.json()["professionals"] == []


@pytest.mark.asyncio
async def test_referral_honours_explicit_user_request(client):
    user_token, _ = await _register_user(client, "ask@example.com")
    r = await client.get(
        f"{API}/support/referral?userRequested=true", headers=_bearer(user_token)
    )
    assert r.status_code == 200
    assert r.json()["shouldSuggest"] is True


# ---- consent gating ----------------------------------------------------------


@pytest.mark.asyncio
async def test_client_insights_require_consent(client):
    user_token, user_id = await _register_user(client, "cu@example.com")
    pro = await _register_approved_pro(client, "cp@example.com")

    await client.post(
        f"{API}/onboarding",
        headers=_bearer(user_token),
        json={"mood": 2, "stress": 7, "sleep": 2, "anxiety": 2,
              "goals": [], "focusAreas": []},
    )

    # No consent → professional sees nothing.
    blocked = await client.get(
        f"{API}/professional/clients/{user_id}/insights",
        headers=_bearer(pro["token"]),
    )
    assert blocked.status_code == 403

    # Grant a single scope.
    g = await client.post(
        f"{API}/consent",
        headers=_bearer(user_token),
        json={"professionalId": pro["id"], "scopes": ["emotional_profile"]},
    )
    assert g.status_code == 201

    allowed = await client.get(
        f"{API}/professional/clients/{user_id}/insights",
        headers=_bearer(pro["token"]),
    )
    assert allowed.status_code == 200
    sections = allowed.json()["sections"]
    assert "emotional_profile" in sections
    # Non-consented scopes are absent (not just empty).
    assert "journal_summaries" not in sections
    assert "insights" not in sections

    # Revoke → back to blocked.
    rev = await client.delete(
        f"{API}/consent?professionalId={pro['id']}&scope=emotional_profile",
        headers=_bearer(user_token),
    )
    assert rev.status_code == 200
    after = await client.get(
        f"{API}/professional/clients/{user_id}/insights",
        headers=_bearer(pro["token"]),
    )
    assert after.status_code == 403
