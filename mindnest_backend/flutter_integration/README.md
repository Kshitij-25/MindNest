# MindNest — Flutter Integration Contracts

This folder documents the **MindNest wellness API** for the Flutter client
(`mindnest_app`). It is a reference for wiring screens to real endpoints — no
backend changes are required to follow it.

- **Base URL**: `http://<host>:8000` · **API prefix**: `/api/v1`
- **Interactive docs**: `GET /docs` (Swagger) — every endpoint is documented and
  callable there.
- **Auth**: Bearer JWT in `Authorization: Bearer <accessToken>`.

> **Product scope.** This API powers the *wellness* product: onboarding, mood,
> journaling, insights, recommendations, habits, coach, reports. The therapist
> **marketplace, community feed, messaging and bookings are not implemented**
> (postponed to a later phase). Flutter screens for those keep running on mock
> data; they simply have no API behind them yet. See
> [Dashboard divergence](#dashboard-divergence-from-the-marketplace-home).

---

## Conventions (important)

1. **No response envelope.** Success responses are the raw JSON object or a bare
   array — deserialize `response.data` straight into your freezed model. There is
   no `{ "data": ... }` wrapper.
2. **camelCase keys** on every wellness endpoint (`monthLevels`, `analysisStatus`,
   `currentMood`, `streakDays`, …). Your freezed models should use camelCase
   fields (or `@JsonKey`).
3. **Legacy endpoints stay snake_case.** The pre-existing `/assessment/*` flow and
   the `/profile/{mood-summary,history,trends,insights}` endpoints return
   **snake_case** (`overall_mood`, `assessment_id`). The new mirror under
   `/mood/*` is camelCase. Don't mix the two model sets.
4. **Errors** always carry a top-level `message` (what `error_mapper.dart`
   reads), plus a stable `code` and a `detail`:
   ```json
   { "message": "Journal entry not found", "code": "not_found", "detail": "..." }
   ```
   Codes: `unauthorized` (401), `forbidden` (403), `not_found` (404),
   `conflict` (409), `validation_error` (422), `error` (4xx/5xx fallback).
5. **Timestamps** are ISO-8601 strings (naive UTC). Many list/feed items also
   include **pre-formatted display strings** (`dayLabel`, `clockLabel`,
   `relativeTime`) so the client never has to reconstruct them.

---

## Auth + token lifecycle

| Step | Request | Response |
|---|---|---|
| Register | `POST /auth/register` `{ email, password, displayName? }` | `201` `UserOut` |
| Login | `POST /auth/login` **form-encoded** `username=<email>&password=<pwd>` | `{ accessToken, refreshToken, tokenType, expiresInMinutes }` |
| Refresh | `POST /auth/refresh` `{ refreshToken }` | new `{ accessToken, refreshToken, ... }` |
| Logout | `POST /auth/logout` `{ refreshToken }` | `{ message }` (idempotent) |
| Forgot password | `POST /auth/forgot-password` `{ email }` | `{ message }` (always 200, anti-enumeration) |
| Current user | `GET /auth/me` | `UserOut` |

- **Login uses OAuth2 form fields** (`application/x-www-form-urlencoded`), not
  JSON: the email goes in `username`. Everything else is JSON.
- On `401`, call `/auth/refresh` with the stored `refreshToken`; on a `401` from
  refresh, the session was revoked — send the user back to login.
- `expiresInMinutes` is the access-token lifetime; refresh proactively.

---

## First-run flow

```
register → login → GET /onboarding/status
   └─ if !onboarded → POST /onboarding {mood,stress,sleep,anxiety?,goals,focusAreas}
                         → returns the initial emotional profile + recommendations
   └─ else → GET /dashboard
```

`POST /onboarding` seeds a real 10-dimension emotional profile from 5 fields, so
the dashboard, insights and recommendations have content immediately.

---

## Journal analysis: the polling pattern

Journal AI runs **in the background** so the editor never blocks.

```
POST /journal/entries { kind, mood, title, body, tags }
   → 201 { id, analysisStatus: "pending", ... }     // returns immediately

GET /journal/entries/{id}/analysis    // poll
   → { status: "pending", ready: false }            // keep polling (e.g. 1.5s)
   → { status: "ready",   ready: true, emotion, summary, topics[], ... }
```

`analysisStatus` / `status` values:

| value | meaning |
|---|---|
| `pending` | analysis scheduled, poll `…/analysis` |
| `ready` | analysis available |
| `failed` | analysis errored (rare); show the entry without analysis |
| `disabled` | not analysed — entry is a **draft**, body empty, or the user turned **off** `enableJournalAi` in settings |

Poll only while `pending`. Stop on `ready`/`failed`/`disabled`. A `PATCH` that
changes the body re-runs analysis (back to `pending`).

---

## Feature flags (respected server-side)

`GET /settings` returns `featureFlags` (camelCase keys). The backend **honours**
them — e.g. with `enableJournalAi=false`, new entries stay `disabled`; with
`enableCoach=false`, `POST /coach/chat` returns `403`. Toggle via
`PATCH /settings { featureFlags: { enableCoach: false } }`.

Flags: `enableCoach`, `enableJournalAi`, `enableWeeklyReport`,
`enableRecommendations`, `dailyReminder`, `notifications`, `biometricLock`.
Plus `theme` (`system|light|dark`). `GET /settings/flags` returns the catalogue
with each flag's current + default value.

---

## Feature → endpoint → model mapping

| Flutter screen / model | Endpoint(s) | Key fields |
|---|---|---|
| Onboarding | `POST /onboarding`, `GET /onboarding/status` | `mood, stress, sleep, anxiety, goals, focusAreas` → `dimensions[], recommendations[]` |
| Home / Dashboard | `GET /dashboard` | `currentMood, emotionalProfile, streak, weeklyTrend[], latestInsight, recommendations[], recentJournal` |
| Mood check-in | `POST /mood/checkin`, `GET /mood/factors` | `level(1-5), factors[], note` → `overallMood, valence, streak` |
| Mood history / chart | `GET /mood/history` | `monthLevels[28], average, trendLabel, recent[]` |
| Mood calendar | `GET /mood/calendar?year&month` | `days[].{date, level, hasEntry}` |
| Mood insights | `GET /mood/insights` | `streakDays, week[7], month[28], distribution[5], cards[]` |
| Trends (charts) | `GET /mood/trends` (camel) or `GET /profile/trends` (snake) | `trends[].{dimension, points[], drift, direction}` |
| Journal list/editor | `GET/POST/PATCH/DELETE /journal/entries` | `kind, mood, title, body, tags, draft, analysisStatus` |
| Journal prompts | `GET /journal/prompts?kind` | `prompts[]` |
| Journal analysis | `GET /journal/entries/{id}/analysis` | `emotion, summary, topics[], themes[], stressors[], wins[], concerns[], suggestions[]` |
| Insights cards | `GET /insights/{daily,weekly,monthly}` | `headline, insights[], burnout{}` |
| Recommendations | `GET /recommendations`, `POST /recommendations/{id}/feedback` | `kind, title, body, score, reason` · `action` |
| Habits | `GET/POST/PATCH/DELETE /habits`, `/habits/{id}/log`, `/logs`, `/analytics` | `name, kind, cadence, doneToday` · `completionRate, currentStreak, correlation` |
| Adaptive assessment | `GET /assessment/templates`, `POST /assessment/start?template`, `/answer`, `/complete` | templates + adaptive Q&A (snake on the flow) |
| AI Coach | `POST /coach/chat`, `GET /coach/conversations`, `GET /coach/history` | `message` → `reply, conversationId, context` |
| Emotional memory | `GET /memory/search?q` | `results[].{snippet, score, kind}` |
| Weekly report | `GET /reports/weekly`, `/weekly/{periodKey}`, `/weekly/history` | `mood, topTopics[], streak, habitAdherence, followThrough, patterns[], narrative` |
| Analytics | `GET /analytics/emotional-timeline`, `GET /analytics/patterns` | `changes[], drivers[]` · `patterns[]` |
| Notifications | `GET /notifications`, `PATCH /notifications/{id}`, `/mark-all-read` | `type, title, body, unread, relativeTime` |
| Profile | `GET/PATCH /profile` | `name, avatarUrl, about, phone, checkIns, entries, streak, weekActivity[], moodWeek[]` |
| Settings | `GET/PATCH /settings`, `GET /settings/flags` | `featureFlags{}, theme` |

Full request/response shapes per endpoint: **[endpoints.md](./endpoints.md)**.

---

## Dashboard divergence from the marketplace home

The current Flutter home screen is marketplace-centric (appointments, recommended
therapists, community). The new `GET /dashboard` is **wellness-only** and returns:

```
currentMood · emotionalProfile · streak · weeklyTrend[] · latestInsight ·
recommendations[] · recentJournal
```

It deliberately **omits** `appointments`, `therapists`, `recommendedTherapists`,
and any community/feed data. When wiring the home screen, map these cards to the
new keys and hide/disable the marketplace cards (or keep them on mock data) until
that surface is built in a later phase.
