"""Auth: register, login, refresh, logout, me."""


async def test_register_and_login(client):
    r = await client.post(
        "/api/v1/auth/register",
        json={"email": "a@b.io", "password": "secret1", "display_name": "A"},
    )
    assert r.status_code == 201
    r = await client.post(
        "/api/v1/auth/login", data={"username": "a@b.io", "password": "secret1"}
    )
    assert r.status_code == 200
    body = r.json()
    assert body["access_token"] and body["refresh_token"]


async def test_duplicate_email_conflicts(client):
    await client.post("/api/v1/auth/register", json={"email": "d@b.io", "password": "secret1"})
    r = await client.post("/api/v1/auth/register", json={"email": "d@b.io", "password": "secret1"})
    assert r.status_code == 409


async def test_refresh_rotates_tokens(client):
    await client.post("/api/v1/auth/register", json={"email": "r@b.io", "password": "secret1"})
    r = await client.post("/api/v1/auth/login", data={"username": "r@b.io", "password": "secret1"})
    refresh = r.json()["refresh_token"]
    r = await client.post("/api/v1/auth/refresh", json={"refresh_token": refresh})
    assert r.status_code == 200
    assert r.json()["access_token"]


async def test_logout_invalidates_refresh(client):
    await client.post("/api/v1/auth/register", json={"email": "l@b.io", "password": "secret1"})
    r = await client.post("/api/v1/auth/login", data={"username": "l@b.io", "password": "secret1"})
    refresh = r.json()["refresh_token"]
    await client.post("/api/v1/auth/logout", json={"refresh_token": refresh})
    r = await client.post("/api/v1/auth/refresh", json={"refresh_token": refresh})
    assert r.status_code == 401


async def test_me_requires_auth(client):
    assert (await client.get("/api/v1/auth/me")).status_code == 401


async def test_forgot_password_is_safe(client):
    r = await client.post("/api/v1/auth/forgot-password", json={"email": "whoever@b.io"})
    assert r.status_code == 200
    assert "message" in r.json()
