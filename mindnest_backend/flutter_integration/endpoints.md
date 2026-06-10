# MindNest — Endpoint Reference

All paths are prefixed with `/api/v1`. All require `Authorization: Bearer <token>`
**except** `auth/register`, `auth/login`, `auth/forgot-password`, and `auth/refresh`.
Bodies are JSON unless noted. camelCase unless marked _(snake — legacy)_.

---

## Auth

### `POST /auth/register` → 201
```json
// request
{ "email": "you@example.com", "password": "secret1", "displayName": "Ada" }
// response (UserOut — snake)
{ "id": "…", "email": "you@example.com", "display_name": "Ada", "created_at": "2026-06-04T09:00:00" }
```

### `POST /auth/login` → 200  _(form-encoded!)_
```
Content-Type: application/x-www-form-urlencoded
username=you@example.com&password=secret1
```
```json
{ "access_token": "ey…", "refresh_token": "ey…", "token_type": "bearer", "expires_in_minutes": 10080 }
```

### `POST /auth/refresh` → 200 · `{ "refresh_token": "ey…" }` → same token shape as login. `401` if revoked.
### `POST /auth/logout` → 200 · `{ "refresh_token": "ey…" }` → `{ "message": "Logged out" }`
### `POST /auth/forgot-password` → 200 · `{ "email": "…" }` → `{ "message": "If that email is registered…" }`
### `GET /auth/me` → `UserOut`

---

## Onboarding

### `GET /onboarding/status`
```json
{ "onboarded": false, "completed": false, "goals": [], "focusAreas": [] }
```

### `POST /onboarding`
```json
// request
{ "mood": 2, "stress": 8, "sleep": 2, "anxiety": 3, "goals": ["sleep better"], "focusAreas": ["stress"] }
// response (OnboardingResult)
{
  "onboarded": true,
  "assessmentId": "…",
  "createdAt": "2026-06-04T09:00:00",
  "overallMood": "Stressed and anxious",
  "valence": -5.5,
  "arousal": 41.0,
  "confidence": 0.62,
  "summary": "Overall you seem stressed and anxious. …",
  "dimensions": [ { "dimension": "stress", "label": "Stress", "score": 66.0, "confidence": 0.5, "elevated": true }, … ],
  "topEmotions": [ { "dimension": "anxiety", "label": "Anxiety", "score": 73.4, "elevated": true }, … ],
  "derived": { "burnoutRisk": 35.1, "burnoutLabel": "low", … },
  "recommendations": [ { "id": "…", "kind": "breathing", "title": "Ground with 5-4-3-2-1", "body": "…", "score": 75.4, "reason": "Anxiety is elevated (73/100).", "status": "active", "createdAt": "…" }, … ]
}
```

---

## Mood

### `GET /mood/factors` → `[ { "key": "work", "label": "Work", "polarity": "stressor" }, … ]`

### `POST /mood/checkin`
```json
// request
{ "level": 2, "factors": ["work", "sleep"], "note": "overwhelmed and exhausted" }
// response
{
  "id": "…", "level": 2, "factors": ["work","sleep"], "note": "…",
  "createdAt": "…", "overallMood": "Under pressure", "valence": -12.0,
  "topEmotions": [ … ],
  "streak": { "current": 3, "longest": 6, "goal": 7, "lastCheckinDate": "2026-06-04" }
}
```

### `GET /mood/history?days=28`
```json
{
  "monthLevels": [3,3,3,2,4,3,…],   // length == days (default 28)
  "average": 3.1,
  "trendLabel": "Improving",         // Improving | Declining | Steady
  "recent": [ { "id": "…", "level": 4, "factors": ["exercise"], "note": "", "dayLabel": "Today", "clockLabel": "3:59 PM", "relativeTime": "now", "createdAt": "…" }, … ]
}
```

### `GET /mood/calendar?year=2026&month=6`  _(both optional; default current month)_
```json
{ "year": 2026, "month": 6, "days": [ { "date": "2026-06-01", "day": 1, "level": null, "hasEntry": false }, { "date": "2026-06-04", "day": 4, "level": 3, "hasEntry": true }, … ] }
```

### `GET /mood/trends?days=30`  _(camelCase wrapper over the engine)_
```json
{ "days": 30, "samples": 11, "trends": [ { "dimension": "stress", "label": "Stress", "points": [ { "createdAt": "…", "score": 70.0, "confidence": 0.6 } ], "current": 12.0, "previous": 40.0, "delta": -28.0, "direction": "falling", "drift": -49.2 }, … ] }
```

### `GET /mood/insights?days=7`
```json
{
  "streakDays": 7, "streakGoal": 7, "average": 2.6, "trendLabel": "Improving",
  "week": [3,2,1,2,3,4,4], "month": [ …28 ints… ],
  "distribution": [ { "level": 1, "count": 2 }, { "level": 2, "count": 3 }, … ],   // levels 1..5
  "cards": [ { "title": "A fairly balanced week.", "body": "Your stress eased ~12 points…", "topicIndex": 0, "colorKey": "topic0" }, … ]   // topicIndex 0..4
}
```

---

## Journal

### `GET /journal/entries?limit=50&offset=0&include_drafts=false` → `[ JournalOut ]`
### `POST /journal/entries` → 201 `JournalOut`
```json
// request
{ "kind": "reflection", "prompt": null, "mood": 2, "title": "Rough day", "body": "Work was overwhelming…", "tags": ["work"], "draft": false }
// JournalOut
{
  "id": "…", "kind": "reflection", "prompt": null, "mood": 2, "title": "Rough day", "body": "…",
  "tags": ["work"], "draft": false, "analysisStatus": "pending",
  "createdAt": "…", "updatedAt": "…", "dayLabel": "Today", "clockLabel": "11:02 AM", "relativeTime": "now"
}
```
`kind` ∈ `free|guided|gratitude|reflection`. `PATCH` accepts the same fields (all optional); changing `body` re-triggers analysis.

### `GET /journal/entries/{id}/analysis`  _(poll while pending)_
```json
{
  "journalId": "…", "status": "ready", "ready": true,
  "emotion": "Emotional fatigue",
  "dimensions": { "stress": 19.2, "anxiety": 20.8, "fatigue": 22.4 },
  "summary": "You wrote about work and sleep. Overall this reads as weighed down by emotional fatigue. …",
  "topics": [ { "slug": "work", "name": "Work", "topicIndex": 0, "colorKey": "topic0" }, … ],
  "themes": ["Work","Sleep","Emotional fatigue"],
  "stressors": ["Work","Sleep"], "wins": [], "concerns": ["Emotional fatigue","Anxiety","Stress"],
  "suggestions": ["A gentler evening","Ground with 5-4-3-2-1","Two minutes of box breathing"],
  "sources": ["rule_based"], "model": "template", "createdAt": "…"
}
```
Before the row exists: `{ "journalId": "…", "status": "pending", "ready": false }`.

### `GET /journal/prompts?kind=gratitude` → `{ "kind": "gratitude", "prompts": ["…","…"] }`
### `DELETE /journal/entries/{id}` → 204

---

## Recommendations

### `GET /recommendations` → `[ RecommendationOut ]` (auto-generated on first read, ranked desc)
```json
{ "id": "…", "kind": "breathing", "title": "Two minutes of box breathing", "body": "…", "score": 70.0, "reason": "Stress is sitting around 66/100.", "status": "active", "source": { "dimension": "stress", "value": 66.0 }, "createdAt": "…" }
```
### `POST /recommendations/regenerate` → `[ RecommendationOut ]` (recompute from latest state)
### `POST /recommendations/{id}/feedback`
```json
// request — action ∈ accepted|dismissed|completed|helpful|not_helpful
{ "action": "dismissed" }
// response
{ "id": "…", "recommendationId": "…", "action": "dismissed", "status": "dismissed" }
```
Dismissing/not-helpful **down-ranks that kind** next time; accepted/completed/helpful up-ranks it.

---

## Habits

### `GET /habits?include_inactive=false` → `[ HabitOut ]`
```json
{ "id": "…", "name": "Morning meditation", "kind": "meditation", "cadence": "daily", "targetDimension": "stress", "active": true, "createdAt": "…", "doneToday": true }
```
### `POST /habits` → 201 · `{ "name", "kind", "cadence", "targetDimension"? }` · kind ∈ `meditation|exercise|sleep|hydration|reading|custom`, cadence ∈ `daily|weekly`
### `PATCH /habits/{id}` · `DELETE /habits/{id}` → 204
### `POST /habits/{id}/log`  _(idempotent per day)_
```json
{ "date": "2026-06-04", "done": true, "note": null }   // date optional (defaults today)
// → HabitLogOut: { "id", "habitId", "date", "done", "note", "createdAt" }
```
### `GET /habits/{id}/logs?days=30` → `[ HabitLogOut ]`
### `GET /habits/{id}/analytics`
```json
{
  "habitId": "…", "name": "Morning meditation", "cadence": "daily",
  "completionRate": 0.83, "totalDone": 5, "currentStreak": 3, "longestStreak": 6,
  "correlation": { "label": "stress", "dimension": "stress", "doneAvg": 38.0, "missedAvg": 44.0, "delta": -6.0, "insight": "On days you do this, your stress is 6.0 points lower — that looks better for you." }
}
```
`correlation` is `null` when there isn't enough data yet.

---

## Insights (windowed, cached)

### `GET /insights/daily` · `GET /insights/weekly` · `GET /insights/monthly`
```json
{ "scope": "weekly", "periodKey": "2026-W23", "headline": "Burnout risk is easing this week.", "insights": ["Your stress has eased about 12 points this week — a positive shift.", …], "samples": 11, "burnout": { "first": 60.0, "last": 35.0, "delta": -25.0, "direction": "falling" }, "generatedAt": "…" }
```

---

## Dashboard  _(wellness-only)_

### `GET /dashboard`
```json
{
  "currentMood": { "level": 4, "label": "Upbeat and motivated", "valence": 70.1 },
  "emotionalProfile": { "overallMood": "Upbeat and motivated", "valence": 70.1, "confidence": 0.6, "topEmotions": [ … ], "dimensions": [ { "dimension": "stress", "label": "Stress", "score": 12.0, "elevated": false }, … (10) ] },
  "streak": { "current": 7, "longest": 7, "goal": 7 },
  "weeklyTrend": [3,2,1,2,3,4,4],
  "latestInsight": { "headline": "A fairly balanced week.", "body": "…", "generatedAt": "…" },
  "recommendations": [ RecommendationOut, … (≤3) ],
  "recentJournal": JournalOut | null
}
```
**No** `appointments` / `therapists` / `recommendedTherapists` keys.

---

## Analytics

### `GET /analytics/emotional-timeline?days=30`
```json
{
  "days": 30,
  "changes": [ { "dimension": "stress", "label": "Stress", "drift": 18.0, "direction": "rising", "current": 64.0, "improving": false, "drivers": ["Work","Sleep"], "note": "Stress rose 18 points over 30 days — recurring themes: Work, Sleep." }, … ],
  "drivers": [ { "name": "Work", "count": 4, "kind": "topic" }, { "name": "Exercise", "count": 3, "kind": "factor" }, … ]
}
```

### `GET /analytics/patterns?days=30`
```json
{ "days": 30, "patterns": [ { "title": "Work & difficult days", "body": "Work comes up in 67% of your tougher entries.", "kind": "trigger", "value": 67.0, "topicIndex": 0, "colorKey": "topic0" }, { "title": "Poor sleep & your mood", "body": "Your mood tends to dip on days you log poor sleep.", "kind": "behavior", "value": 0.9, "topicIndex": 1, "colorKey": "topic1" } ] }
```

---

## Weekly reports

### `GET /reports/weekly`  ·  `GET /reports/weekly/{periodKey}` (e.g. `2026-W23`)  ·  `GET /reports/weekly/history?limit=12`
```json
{
  "periodKey": "2026-W23", "narrative": "This week you checked in 4 times…",
  "generatedAt": "…",
  "range": { "start": "2026-06-01", "end": "2026-06-07" },
  "mood": { "average": 2.8, "trendLabel": "Improving", "checkIns": 4 },
  "journalCount": 3, "topTopics": ["Work","Sleep","Money"], "streak": 7,
  "habitAdherence": 0.5,
  "followThrough": { "accepted": 1, "completed": 0, "dismissed": 2 },
  "patterns": [ PatternCard, … ]
}
```
Idempotent within a week (same `periodKey` → same `generatedAt`). `?refresh=true`
on `/reports/weekly` forces regeneration. A new report emits an `insight`
notification.

---

## AI Coach

### `POST /coach/chat`  _(403 if `enableCoach` is off)_
```json
// request — omit conversationId to start a new thread
{ "message": "I feel stressed about work, I can barely sleep.", "conversationId": null }
// response
{
  "conversationId": "…",
  "reply": "It sounds like things have felt stressed and anxious lately… What feels most pressing right now?",
  "model": "template",   // or the Ollama model name when available
  "context": { "mood": "Stressed and anxious", "valence": -5.5, "concerns": ["stress","anxiety","low happiness"], "topEmotions": ["Anxiety"], "recommendations": ["…"], "memories": [ { "kind": "journal", "snippet": "…" } ] },
  "createdAt": "…"
}
```
### `GET /coach/conversations` → `[ { "id", "title", "createdAt", "updatedAt" } ]`
### `GET /coach/history?conversation_id=…` → `[ { "id", "conversationId", "role", "content", "createdAt" } ]` (role ∈ `user|assistant`)

---

## Emotional memory

### `GET /memory/search?q=work%20stress&top_k=5`
```json
{ "query": "work stress", "results": [ { "id": "…", "kind": "journal", "refId": "…", "summary": "…", "snippet": "Work has been overwhelming…", "score": 0.71, "createdAt": "…" } ] }
```
With embeddings enabled this is semantic; offline it falls back to keyword scoring.

---

## Notifications

### `GET /notifications?unread_only=false&limit=50`
```json
[ { "id": "…", "type": "insight", "title": "Your weekly wellness report is ready", "body": "…", "unread": true, "refId": "2026-W23", "relativeTime": "2h", "createdAt": "…" } ]
```
`type` ∈ `mood|content|insight|system`.
### `PATCH /notifications/{id}` → marks one read (`NotificationOut`)
### `PATCH /notifications/mark-all-read` → `{ "ok": true }`

---

## Profile & settings

### `GET /profile`
```json
{ "id": "…", "name": "Ada", "email": "…", "avatarUrl": null, "about": null, "phone": null, "onboarded": true, "checkIns": "12", "entries": "3", "streak": "7", "weekActivity": [ { "icon": "heart", "value": "4", "label": "Check-ins", "colorKey": "clay" }, … ], "moodWeek": [3,3,2,4,3,4,4] }
```
### `PATCH /profile` · `{ "name"?, "avatarUrl"?, "about"?, "phone"? }`
### `GET /settings`
```json
{ "featureFlags": { "enableCoach": true, "enableJournalAi": true, "enableWeeklyReport": true, "enableRecommendations": true, "dailyReminder": true, "notifications": true, "biometricLock": false }, "theme": "system" }
```
### `PATCH /settings` · `{ "featureFlags"?: { … }, "theme"?: "dark" }` (accepts camel or snake flag keys)
### `GET /settings/flags` → `{ "flags": [ { "key": "enableCoach", "value": true, "default": true }, … ] }`

---

## Adaptive assessment  _(flow is snake_case — legacy)_

### `GET /assessment/templates` _(camel)_ → `[ { "id": "daily_checkin", "name": "Daily check-in", "description": "…", "minQuestions": 3, "maxQuestions": 5, "focus": [] } ]`
### `POST /assessment/start?template=daily_checkin` → `NextQuestion` _(snake)_
```json
{ "assessment_id": "…", "done": false, "question": { "id": "…", "text": "…", "type": "emoji", "options": [ … ] }, "progress": { "answered": 0, "min": 3, "max": 5, "fraction": 0.0 }, "interim_top": [] }
```
### `POST /assessment/answer?assessment_id=…` · body `{ "question_id", "option_id"? , "value"?, "text"?, "skipped"? }` → next question
### `GET /assessment/next-question?assessment_id=…` → same shape (idempotent)
### `POST /assessment/complete?assessment_id=…` → `MoodSummary` _(snake)_
### `GET /assessment/history` _(camel)_ → `[ { "assessmentId", "template", "source", "createdAt", "overallMood", "valence", "confidence", "topEmotions" } ]`
### `GET /assessment/result/{assessmentId}` → `MoodSummary` _(snake)_

Templates: `adaptive` (full), `daily_checkin`, `weekly_reflection`, `burnout`,
`motivation`, `anxiety`.

---

## System

### `GET /health` → `{ "status": "ok", … }` · `GET /ai/status` → AI layer availability (rule-based always on; transformer/embeddings/LLM optional).
