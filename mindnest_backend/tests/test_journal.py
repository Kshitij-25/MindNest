"""Journal CRUD + background analysis + feature-flag gating."""


async def test_create_runs_background_analysis(auth):
    r = await auth.post(
        "/api/v1/journal/entries",
        json={"kind": "reflection", "mood": 2,
              "body": "Work was overwhelming and I felt anxious and exhausted."},
    )
    assert r.status_code == 201
    jid = r.json()["id"]
    assert r.json()["analysisStatus"] in ("pending", "ready")

    # Background task completes within the ASGI request cycle under httpx.
    r = await auth.get(f"/api/v1/journal/entries/{jid}/analysis")
    body = r.json()
    assert body["ready"] is True
    assert body["sources"] == ["rule_based"]  # AI off -> rule-based only
    assert body["dimensions"] and body["concerns"]


async def test_draft_skips_analysis(auth):
    r = await auth.post(
        "/api/v1/journal/entries",
        json={"kind": "free", "mood": 3, "body": "half written", "draft": True},
    )
    assert r.json()["analysisStatus"] == "disabled"


async def test_feature_flag_disables_analysis(auth):
    await auth.patch("/api/v1/settings", json={"featureFlags": {"enableJournalAi": False}})
    r = await auth.post(
        "/api/v1/journal/entries",
        json={"kind": "free", "mood": 4, "body": "AI is off for this entry."},
    )
    assert r.json()["analysisStatus"] == "disabled"


async def test_drafts_excluded_from_list(auth):
    await auth.post("/api/v1/journal/entries", json={"kind": "free", "mood": 3, "body": "published"})
    await auth.post("/api/v1/journal/entries", json={"kind": "free", "mood": 3, "body": "draft", "draft": True})
    r = await auth.get("/api/v1/journal/entries")
    assert len(r.json()) == 1
    r = await auth.get("/api/v1/journal/entries?include_drafts=true")
    assert len(r.json()) == 2


async def test_delete_entry(auth):
    r = await auth.post("/api/v1/journal/entries", json={"kind": "free", "mood": 3, "body": "to delete"})
    jid = r.json()["id"]
    assert (await auth.delete(f"/api/v1/journal/entries/{jid}")).status_code == 204
    assert (await auth.get(f"/api/v1/journal/entries/{jid}")).status_code == 404
