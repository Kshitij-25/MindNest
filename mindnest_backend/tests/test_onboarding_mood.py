"""Onboarding bridge + mood tracking slice."""


async def test_onboarding_seeds_profile_and_recommendations(auth):
    r = await auth.post(
        "/api/v1/onboarding",
        json={"mood": 2, "stress": 8, "sleep": 2, "anxiety": 3,
              "goals": ["calm"], "focusAreas": ["stress"]},
    )
    assert r.status_code == 200
    body = r.json()
    assert body["onboarded"] is True
    dims = {d["dimension"]: d["score"] for d in body["dimensions"]}
    assert dims["stress"] > 50 and dims["anxiety"] > 50
    assert body["recommendations"]  # non-empty


async def test_checkin_builds_history_and_trends(auth):
    await auth.post("/api/v1/onboarding", json={"mood": 3, "stress": 5, "sleep": 3})
    r = await auth.post(
        "/api/v1/mood/checkin",
        json={"level": 2, "factors": ["work", "sleep"], "note": "overwhelmed and exhausted"},
    )
    assert r.status_code == 200
    assert r.json()["streak"]["current"] >= 1

    r = await auth.get("/api/v1/mood/history")
    assert len(r.json()["monthLevels"]) == 28

    r = await auth.get("/api/v1/mood/trends")
    assert r.json()["samples"] >= 2  # onboarding + checkin on one timeline


async def test_mood_insights_shape(auth):
    await auth.post("/api/v1/onboarding", json={"mood": 3, "stress": 5, "sleep": 3})
    await auth.post("/api/v1/mood/checkin", json={"level": 4, "factors": ["exercise"]})
    r = await auth.get("/api/v1/mood/insights")
    body = r.json()
    assert len(body["week"]) == 7 and len(body["month"]) == 28
    assert len(body["distribution"]) == 5
    for card in body["cards"]:
        assert 0 <= card["topicIndex"] <= 4


async def test_calendar_covers_month(auth):
    await auth.post("/api/v1/mood/checkin", json={"level": 3, "factors": []})
    r = await auth.get("/api/v1/mood/calendar")
    days = r.json()["days"]
    assert len(days) >= 28
    assert any(d["hasEntry"] for d in days)
