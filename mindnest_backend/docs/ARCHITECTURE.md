# Architecture

MindNest is a layered, local-first FastAPI service. Each layer degrades
gracefully: the system is fully functional on the rule-based core and gets
sharper as you enable the optional ML/LLM layers.

```
┌──────────────────────────────────────────────────────────────────┐
│                        Flutter app (Dio + BLoC)                    │
└───────────────────────────────┬──────────────────────────────────┘
                                 │ REST + JWT
┌───────────────────────────────▼──────────────────────────────────┐
│  API layer  (app/api)                                              │
│    routes: auth · assessment · profile · system     deps: get_user│
└───────────────────────────────┬──────────────────────────────────┘
                                 │
┌───────────────────────────────▼──────────────────────────────────┐
│  Service layer  (app/services)                                     │
│    assessment_service ── orchestration (DB + engine + AI)          │
│    questionnaire_engine ─ adaptive selection / branching           │
│    scoring ───────────── 0..100 dimensions, confidence, derived    │
│    mood_service ───────── finalize profile, embeddings, summary    │
│    insights_service ───── trends, drift, weekly insights           │
└──────────────┬───────────────────────────────┬───────────────────┘
               │                                │
┌──────────────▼──────────────┐   ┌─────────────▼─────────────────────┐
│  AI pipeline  (app/ai)      │   │  Persistence  (app/models + DB)   │
│   rule_based  (always on)   │   │   SQLAlchemy 2.0 async             │
│   emotion_classifier (opt)  │   │   SQLite (MVP) → Postgres (swap)  │
│   embeddings  (opt)         │   │   users · assessments · questions │
│   llm / Ollama (opt)        │   │   answers · mood_profiles ·       │
│                             │   │   emotional_history · embeddings  │
└─────────────────────────────┘   └───────────────────────────────────┘
```

## Request flow: one adaptive assessment

1. **`POST /assessment/start`** → creates an `Assessment`, the engine returns
   the first seed question.
2. **`POST /assessment/answer`** (repeat):
   - free-text/journal answers run through `ai.pipeline.analyze_text`
     (rule-based + transformer) → dimension deltas;
   - the per-answer contribution is cached in `Answer.derived`;
   - `scoring.aggregate` recomputes the full state from **all** answers;
   - `questionnaire_engine.select_next_question` picks the next item from
     branching → contradiction → coverage/depth need.
3. **`POST /assessment/complete`** → `mood_service` builds the durable
   `MoodProfile`, writes `EmotionalHistory` rows, stores an embedding, and
   generates the summary (LLM → template fallback).
4. **`GET /profile/*`** → mood summary, history, trends, weekly insights.

## Why stateless recomputation?

The engine is a **pure function** of `(answers, score_state)`. State is always
rebuilt from stored answers, so:
- `next-question` and `answer` are **idempotent** (safe retries / offline replay);
- the engine and scorer are trivially unit-testable with no DB;
- there's no server-side session drift to reconcile.

## The hybrid scoring model

Every signal lands on a shared **0..100 per-dimension** scale (10 dimensions).

| Source | Role | Always on? |
| --- | --- | --- |
| Rule-based lexicon | keyword deltas w/ negation + intensifiers | ✅ |
| Multiple-choice / slider weights | structured deltas (valence-aware sliders) | ✅ |
| Transformer (DistilRoBERTa) | nuanced emotion probs → dimension deltas | optional |
| Embeddings (MiniLM) | similarity memory over past entries | optional |
| LLM (Ollama) | natural-language summary | optional |

`scoring.aggregate` then derives **confidence** (evidence count × signal
agreement), **contradictions** (within- and cross-dimension sign conflicts),
**valence/arousal**, **burnout risk** and the **overall mood label**.

## Adaptivity

`select_next_question` priority order:
1. **Branching** — a question's `follow_ups` triggered by the last answer.
2. **Contradiction** — inject a `clarify`-stage question to resolve mixed signals.
3. **Stop** — past `MAX_QUESTIONS`, or past `MIN_QUESTIONS` with confidence ≥ target.
4. **Coverage/depth** — score candidates by a per-dimension *need* model
   (cover untouched dimensions early; probe elevated/uncertain ones later).

## Data model (SQLite → Postgres)

All models are SQLAlchemy 2.0 async with JSON columns for flexible payloads.
Switching to Postgres is a `DATABASE_URL` change (`postgresql+asyncpg://…`).
Embeddings are JSON float lists (fine for the MVP); swap the `embeddings`
table for `pgvector` at scale without touching the API.

## Extending

- **New question** → add to `app/data/questions.json` (no code).
- **New dimension** → add to `app/core/dimensions.py` + question weights.
- **Swap the emotion model** → set `EMOTION_MODEL`; map its labels in
  `EMOTION_LABEL_TO_DIMENSIONS`.
- **Swap the LLM** → `ollama pull <model>` + set `OLLAMA_MODEL`.
