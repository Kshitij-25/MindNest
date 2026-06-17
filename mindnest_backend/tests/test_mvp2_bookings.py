"""MVP 2 — availability → booking lifecycle → review."""
from __future__ import annotations

import pytest

API = "/api/v1"
ADMIN_TOKEN = "test-admin-token"


def _bearer(token: str) -> dict:
    return {"Authorization": f"Bearer {token}"}


async def _register_user(client, email: str) -> str:
    await client.post(
        f"{API}/auth/register",
        json={"email": email, "password": "secret1", "display_name": "U"},
    )
    r = await client.post(
        f"{API}/auth/login", data={"username": email, "password": "secret1"}
    )
    return r.json()["access_token"]


async def _register_approved_pro(client, email: str) -> dict:
    from app.config import settings

    settings.ADMIN_API_TOKEN = ADMIN_TOKEN
    await client.post(
        f"{API}/professional/auth/register",
        json={"email": email, "password": "secret1", "name": "Dr Pro",
              "specializations": ["burnout"]},
    )
    login = await client.post(
        f"{API}/professional/auth/login",
        data={"username": email, "password": "secret1"},
    )
    pro_token = login.json()["access_token"]
    me = await client.get(f"{API}/professional/auth/me", headers=_bearer(pro_token))
    pro_id = me.json()["id"]

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

    # A weekly availability window (Mon 09:00–12:00, 60-min slots).
    await client.post(
        f"{API}/professional/availability/rules",
        headers=_bearer(pro_token),
        json={"weekday": 0, "startMinute": 540, "endMinute": 720, "slotMinutes": 60},
    )
    return {"token": pro_token, "id": pro_id}


@pytest.mark.asyncio
async def test_full_booking_lifecycle_and_single_review(client):
    user_token = await _register_user(client, "bu@example.com")
    pro = await _register_approved_pro(client, "bp@example.com")

    # Availability is generated lazily on listing.
    slots = await client.get(
        f"{API}/professionals/{pro['id']}/availability", headers=_bearer(user_token)
    )
    assert slots.status_code == 200
    assert len(slots.json()) > 0
    slot_id = slots.json()[0]["id"]

    # Book it.
    r = await client.post(
        f"{API}/bookings",
        headers=_bearer(user_token),
        json={"professionalId": pro["id"], "slotId": slot_id},
    )
    assert r.status_code == 201, r.text
    booking = r.json()
    assert booking["status"] == "pending"
    assert booking["canReview"] is False
    booking_id = booking["id"]

    # Double-booking the same slot is rejected.
    dup = await client.post(
        f"{API}/bookings",
        headers=_bearer(user_token),
        json={"professionalId": pro["id"], "slotId": slot_id},
    )
    assert dup.status_code == 409

    # Cannot complete before confirming.
    early = await client.post(
        f"{API}/professional/bookings/{booking_id}/complete",
        headers=_bearer(pro["token"]),
    )
    assert early.status_code == 409

    # Confirm → complete.
    r = await client.post(
        f"{API}/professional/bookings/{booking_id}/confirm", headers=_bearer(pro["token"])
    )
    assert r.json()["status"] == "confirmed"
    r = await client.post(
        f"{API}/professional/bookings/{booking_id}/complete", headers=_bearer(pro["token"])
    )
    assert r.json()["status"] == "completed"

    # Now the booking is reviewable.
    got = await client.get(f"{API}/bookings/{booking_id}", headers=_bearer(user_token))
    assert got.json()["canReview"] is True

    r = await client.post(
        f"{API}/bookings/{booking_id}/review",
        headers=_bearer(user_token),
        json={"rating": 5, "comment": "Great"},
    )
    assert r.status_code == 201

    # One review per booking.
    again = await client.post(
        f"{API}/bookings/{booking_id}/review",
        headers=_bearer(user_token),
        json={"rating": 4},
    )
    assert again.status_code == 409

    # Rating aggregate propagated to the professional.
    detail = await client.get(
        f"{API}/professionals/{pro['id']}", headers=_bearer(user_token)
    )
    assert detail.json()["rating"] == 5.0
    assert detail.json()["reviewCount"] == 1


@pytest.mark.asyncio
async def test_cancel_frees_the_slot(client):
    user_token = await _register_user(client, "cu@example.com")
    pro = await _register_approved_pro(client, "cp@example.com")

    slots = await client.get(
        f"{API}/professionals/{pro['id']}/availability", headers=_bearer(user_token)
    )
    slot_id = slots.json()[0]["id"]
    n_before = len(slots.json())

    booked = await client.post(
        f"{API}/bookings",
        headers=_bearer(user_token),
        json={"professionalId": pro["id"], "slotId": slot_id},
    )
    booking_id = booked.json()["id"]

    # Slot disappears from availability while booked.
    mid = await client.get(
        f"{API}/professionals/{pro['id']}/availability", headers=_bearer(user_token)
    )
    assert len(mid.json()) == n_before - 1

    # Cancelling frees it again.
    r = await client.post(
        f"{API}/bookings/{booking_id}/cancel", headers=_bearer(user_token)
    )
    assert r.json()["status"] == "cancelled"
    after = await client.get(
        f"{API}/professionals/{pro['id']}/availability", headers=_bearer(user_token)
    )
    assert len(after.json()) == n_before
