"""Recommendations feedback loop, habits, coach, dashboard, reports, analytics."""


async def _onboard(auth, **kw):
    payload = {"mood": 2, "stress": 8, "sleep": 2, "anxiety": 3}
    payload.update(kw)
    await auth.post("/api/v1/onboarding", json=payload)


async def test_recommendation_feedback_downranks_kind(auth):
    await _onboard(auth)
    recs = (await auth.get("/api/v1/recommendations")).json()
    breathing = [r for r in recs if r["kind"] == "breathing"]
    assert breathing
    before = breathing[0]["score"]
    await auth.post(f"/api/v1/recommendations/{breathing[0]['id']}/feedback",
                    json={"action": "dismissed"})
    recs2 = (await auth.post("/api/v1/recommendations/regenerate")).json()
    after = [r for r in recs2 if r["kind"] == "breathing"]
    assert not after or after[0]["score"] < before


async def test_habit_log_idempotent_and_analytics(auth):
    r = await auth.post("/api/v1/habits",
                        json={"name": "Meditate", "kind": "meditation",
                              "cadence": "daily", "targetDimension": "stress"})
    hid = r.json()["id"]
    await auth.post(f"/api/v1/habits/{hid}/log", json={"done": True})
    await auth.post(f"/api/v1/habits/{hid}/log", json={"done": True})  # same day
    logs = (await auth.get(f"/api/v1/habits/{hid}/logs")).json()
    assert len(logs) == 1  # idempotent per day
    a = (await auth.get(f"/api/v1/habits/{hid}/analytics")).json()
    assert a["currentStreak"] >= 1 and 0 <= a["completionRate"] <= 1


async def test_coach_grounded_and_flag_gated(auth):
    await _onboard(auth)
    r = await auth.post("/api/v1/coach/chat", json={"message": "I feel stressed about work."})
    assert r.status_code == 200
    body = r.json()
    assert body["reply"] and body["conversationId"]
    assert "mood" in body["context"]

    await auth.patch("/api/v1/settings", json={"featureFlags": {"enableCoach": False}})
    r = await auth.post("/api/v1/coach/chat", json={"message": "hello"})
    assert r.status_code == 403


async def test_dashboard_is_wellness_only(auth):
    await _onboard(auth)
    r = await auth.get("/api/v1/dashboard")
    body = r.json()
    for k in ("currentMood", "emotionalProfile", "streak", "weeklyTrend",
              "latestInsight", "recommendations", "recentJournal"):
        assert k in body
    assert not any(k in body for k in ("appointments", "therapists", "recommendedTherapists"))
    assert len(body["weeklyTrend"]) == 7


async def test_weekly_report_idempotent(auth):
    await _onboard(auth)
    await auth.post("/api/v1/mood/checkin", json={"level": 2, "factors": ["work"]})
    r1 = (await auth.get("/api/v1/reports/weekly")).json()
    r2 = (await auth.get("/api/v1/reports/weekly")).json()
    assert r1["periodKey"] == r2["periodKey"]
    assert r1["generatedAt"] == r2["generatedAt"]  # cached, not regenerated


async def test_insights_windows(auth):
    await _onboard(auth)
    for scope in ("daily", "weekly", "monthly"):
        r = await auth.get(f"/api/v1/insights/{scope}")
        assert r.status_code == 200
        assert r.json()["scope"] == scope


async def test_assessment_templates_and_history(auth):
    await _onboard(auth)
    r = await auth.get("/api/v1/assessment/templates")
    assert len(r.json()) >= 5
    r = await auth.get("/api/v1/assessment/history")
    assert any(h["source"] == "onboarding" for h in r.json())
