"""Wire conventions: error envelope + camel/snake split."""


async def test_error_envelope_unauthenticated(client):
    r = await client.get("/api/v1/dashboard")
    assert r.status_code == 401
    body = r.json()
    assert "message" in body and "code" in body


async def test_error_envelope_not_found(auth):
    r = await auth.get("/api/v1/journal/entries/does-not-exist/analysis")
    assert r.status_code == 404
    body = r.json()
    assert body["message"] and body["code"] == "not_found"


async def test_validation_error_has_message(auth):
    r = await auth.post("/api/v1/mood/checkin", json={"level": 99})
    assert r.status_code == 422
    assert "message" in r.json()


async def test_legacy_profile_stays_snake_case(auth):
    await auth.post("/api/v1/onboarding", json={"mood": 3, "stress": 5, "sleep": 3})
    r = await auth.get("/api/v1/profile/mood-summary")
    assert r.status_code == 200
    assert "overall_mood" in r.json()  # snake, not overallMood


async def test_new_endpoint_is_camel_case(auth):
    r = await auth.get("/api/v1/mood/history")
    assert r.status_code == 200
    assert "monthLevels" in r.json()
