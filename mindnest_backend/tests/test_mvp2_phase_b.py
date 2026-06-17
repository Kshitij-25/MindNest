"""MVP 2 Phase B — messaging, community feed and wellness programs."""
from __future__ import annotations

import pytest

API = "/api/v1"


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


async def _register_pro(client, email: str) -> dict:
    await client.post(
        f"{API}/professional/auth/register",
        json={"email": email, "password": "secret1", "name": "Dr Pro",
              "specializations": ["stress"]},
    )
    login = await client.post(
        f"{API}/professional/auth/login",
        data={"username": email, "password": "secret1"},
    )
    token = login.json()["access_token"]
    pid = (await client.get(f"{API}/professional/auth/me", headers=_bearer(token))).json()["id"]
    return {"token": token, "id": pid}


# ---- messaging ---------------------------------------------------------------


@pytest.mark.asyncio
async def test_messaging_two_way(client):
    user_token = await _register_user(client, "mu@example.com")
    pro = await _register_pro(client, "mp@example.com")

    conv = await client.post(
        f"{API}/messaging/conversations",
        headers=_bearer(user_token),
        json={"professionalId": pro["id"]},
    )
    assert conv.status_code == 201
    conv_id = conv.json()["id"]

    await client.post(
        f"{API}/messaging/conversations/{conv_id}/messages",
        headers=_bearer(user_token),
        json={"body": "Hello, I'd like help with stress."},
    )

    # The professional sees the conversation with one unread message.
    pro_convs = await client.get(
        f"{API}/messaging/pro/conversations", headers=_bearer(pro["token"])
    )
    assert pro_convs.status_code == 200
    assert len(pro_convs.json()) == 1
    assert pro_convs.json()[0]["unreadCount"] == 1

    # Pro reads (marks read) then replies.
    await client.get(
        f"{API}/messaging/pro/conversations/{conv_id}/messages",
        headers=_bearer(pro["token"]),
    )
    reply = await client.post(
        f"{API}/messaging/pro/conversations/{conv_id}/messages",
        headers=_bearer(pro["token"]),
        json={"body": "Happy to help — let's book a session."},
    )
    assert reply.status_code == 201
    assert reply.json()["senderType"] == "professional"

    # User now sees the reply.
    msgs = await client.get(
        f"{API}/messaging/conversations/{conv_id}/messages", headers=_bearer(user_token)
    )
    bodies = [m["body"] for m in msgs.json()]
    assert any("book a session" in b for b in bodies)

    # A different user cannot read this conversation.
    other = await _register_user(client, "other@example.com")
    forbidden = await client.get(
        f"{API}/messaging/conversations/{conv_id}/messages", headers=_bearer(other)
    )
    assert forbidden.status_code == 404


# ---- community ---------------------------------------------------------------


@pytest.mark.asyncio
async def test_community_post_like_comment_save(client):
    user_token = await _register_user(client, "cu@example.com")

    created = await client.post(
        f"{API}/community/posts",
        headers=_bearer(user_token),
        json={"type": "reflection", "title": "Small win", "body": "Took a walk today."},
    )
    assert created.status_code == 201
    post_id = created.json()["id"]

    feed = await client.get(f"{API}/community/posts", headers=_bearer(user_token))
    assert any(p["id"] == post_id for p in feed.json())

    liked = await client.post(
        f"{API}/community/posts/{post_id}/like", headers=_bearer(user_token)
    )
    assert liked.json()["likeCount"] == 1
    assert liked.json()["likedByMe"] is True
    # Idempotent like.
    liked2 = await client.post(
        f"{API}/community/posts/{post_id}/like", headers=_bearer(user_token)
    )
    assert liked2.json()["likeCount"] == 1

    commented = await client.post(
        f"{API}/community/posts/{post_id}/comments",
        headers=_bearer(user_token),
        json={"body": "Love this!"},
    )
    assert commented.status_code == 201

    await client.post(f"{API}/community/posts/{post_id}/save", headers=_bearer(user_token))
    saved = await client.get(f"{API}/community/posts/saved", headers=_bearer(user_token))
    assert any(p["id"] == post_id for p in saved.json())

    detail = await client.get(
        f"{API}/community/posts/{post_id}", headers=_bearer(user_token)
    )
    assert detail.json()["commentCount"] == 1
    assert detail.json()["savedByMe"] is True


@pytest.mark.asyncio
async def test_professional_can_publish_expert_content(client):
    pro = await _register_pro(client, "expert@example.com")
    user_token = await _register_user(client, "reader@example.com")

    article = await client.post(
        f"{API}/community/posts",
        headers=_bearer(pro["token"]),
        json={"type": "article", "title": "Managing stress", "body": "..."},
    )
    assert article.status_code == 201
    assert article.json()["authorType"] == "professional"

    feed = await client.get(f"{API}/community/posts", headers=_bearer(user_token))
    assert any(p["type"] == "article" for p in feed.json())


# ---- programs ----------------------------------------------------------------


@pytest.mark.asyncio
async def test_programs_authoring_and_browsing(client):
    pro = await _register_pro(client, "pp@example.com")
    user_token = await _register_user(client, "learner@example.com")

    program = await client.post(
        f"{API}/programs",
        headers=_bearer(pro["token"]),
        json={"title": "Burnout Recovery", "description": "4 weeks", "category": "burnout"},
    )
    assert program.status_code == 201
    program_id = program.json()["id"]

    await client.post(
        f"{API}/programs/{program_id}/lessons",
        headers=_bearer(pro["token"]),
        json={"title": "Week 1", "content": "Rest", "journalPrompt": "How rested?",
              "orderIndex": 0},
    )

    # A user can browse and read the program with its lessons.
    listing = await client.get(f"{API}/programs", headers=_bearer(user_token))
    assert any(p["id"] == program_id for p in listing.json())

    detail = await client.get(f"{API}/programs/{program_id}", headers=_bearer(user_token))
    assert detail.json()["lessonCount"] == 1
    assert detail.json()["lessons"][0]["title"] == "Week 1"

    # A user may NOT author a program.
    forbidden = await client.post(
        f"{API}/programs",
        headers=_bearer(user_token),
        json={"title": "Nope"},
    )
    assert forbidden.status_code == 401
