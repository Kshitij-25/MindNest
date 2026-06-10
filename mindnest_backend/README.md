# 🧠 MindNest — Local-First Adaptive Mood Intelligence

MindNest is an **adaptive mood-assessment engine**: a dynamic questionnaire
that branches on your answers, a hybrid AI pipeline that reads emotional
state, and a long-term memory that tracks trends, drift and burnout over time.

It runs **entirely on a normal laptop**, works **offline**, and uses **only
open-source models** — no OpenAI, no Claude, no Gemini, no paid databases, no
paid hosting. The lightweight core has **zero ML dependencies**; the
transformer / embedding / LLM layers are optional and load lazily.

> ⚠️ **Not a medical device.** MindNest does not diagnose and is not a
> substitute for professional care. It's a self-reflection companion.

---

## ✨ What it does

- **Adaptive questionnaire** — branches on previous answers, emotional
  intensity, uncertainty, contradictions and skipped questions.
- **Detects 10 dimensions** — stress, anxiety, sadness, happiness, burnout
  risk, emotional fatigue, loneliness, anger, emotional instability, motivation.
- **Hybrid analysis** — rule-based scoring + transformer emotion classifier +
  embedding similarity + local-LLM reasoning, fused on one 0–100 scale.
- **Confidence & contradictions** — every read has a confidence score and
  flags conflicting signals (and asks to clarify them).
- **Long-term memory** — historical moods, embeddings, trends, emotional
  drift, burnout progression and weekly insights.
- **Mobile-ready** — clean JSON API + a full Flutter integration layer.

## 🧱 Tech stack

| Layer | Choice |
| --- | --- |
| API | FastAPI (async) + Pydantic v2, JWT auth, Swagger |
| DB | SQLAlchemy 2.0 async · SQLite (MVP) → Postgres (swap a URL) |
| Rule engine | pure-Python lexicon + scoring (always on) |
| Emotion model | `j-hartmann/emotion-english-distilroberta-base` (optional) |
| Embeddings | `sentence-transformers/all-MiniLM-L6-v2` (optional) |
| Local LLM | Ollama — TinyLlama / Phi-3 / Mistral (optional) |
| Client | Flutter + Dio + flutter_bloc |

---

## 🚀 Quickstart (≈60 seconds, no models needed)

```bash
cd mindnest
python -m venv .venv && source .venv/bin/activate     # Windows: .venv\Scripts\activate
pip install -r requirements.txt

# optional: seed a demo user with 2 weeks of history
python -m scripts.seed_demo                            # demo@mindnest.app / demo12345

uvicorn app.main:app --reload
```

Open the interactive docs at **<http://localhost:8000/docs>**.

### Turn on the AI layers (optional)
```bash
pip install -r requirements-ai.txt    # transformer + embeddings (CPU, free)
# and/or run a local LLM:
ollama serve && ollama pull tinyllama # see docs/OLLAMA_SETUP.md
```
The app auto-detects what's available — check `GET /api/v1/ai/status`.

### Try the flow with curl
```bash
# register + login
curl -s localhost:8000/api/v1/auth/register -H 'content-type: application/json' \
  -d '{"email":"you@example.com","password":"secret123"}'
TOKEN=$(curl -s localhost:8000/api/v1/auth/login \
  -d 'username=you@example.com&password=secret123' | python -c 'import sys,json;print(json.load(sys.stdin)["access_token"])')

# start an assessment
curl -s localhost:8000/api/v1/assessment/start -X POST \
  -H "authorization: Bearer $TOKEN" -H 'content-type: application/json' -d '{"meta":{}}'
# → answer with POST /assessment/answer?assessment_id=... then POST /assessment/complete
```

---

## 📡 API

Base path: `/api/v1` · Auth: `Authorization: Bearer <jwt>` · Docs: `/docs`

| Method | Path | Purpose |
| --- | --- | --- |
| `POST` | `/auth/register` | Create an account |
| `POST` | `/auth/login` | Get a JWT (OAuth2 form) |
| `GET`  | `/auth/me` | Current user |
| `POST` | `/assessment/start` | Begin an assessment → first question |
| `POST` | `/assessment/answer?assessment_id=` | Submit an answer → next question |
| `GET`  | `/assessment/next-question?assessment_id=` | Re-fetch current question |
| `POST` | `/assessment/complete?assessment_id=` | Finalize → mood profile |
| `GET`  | `/profile/mood-summary` | Latest mood profile |
| `GET`  | `/profile/history?limit=` | Past assessments |
| `GET`  | `/profile/trends?days=` | Per-dimension trend series |
| `GET`  | `/profile/insights?days=` | Weekly insights + burnout progression |
| `GET`  | `/health`, `/ai/status` | Health + AI layer status |

---

## 📁 Project structure

```
mindnest/
├── app/
│   ├── main.py                # FastAPI app + lifespan (init db, seed questions)
│   ├── config.py              # pydantic-settings (.env)
│   ├── database.py            # async engine / session / Base
│   ├── core/                  # security (JWT), dimensions, utils
│   ├── models/                # SQLAlchemy models (the schema)
│   ├── schemas/               # Pydantic request/response models
│   ├── api/                   # routes + deps + router
│   ├── services/              # engine, scoring, assessment/mood/insights
│   ├── ai/                    # rule_based · emotion_classifier · embeddings · llm · pipeline
│   └── data/                  # questions.json · sample_dataset.json
├── scripts/seed_demo.py       # demo user + 2 weeks of history
├── tests/                     # 45 tests (unit + API + pipeline)
├── flutter_integration/       # Dart models · Dio client · repo · BLoC
├── docs/                      # ARCHITECTURE · OLLAMA_SETUP · DEPLOYMENT
├── Dockerfile · docker-compose.yml
├── requirements.txt           # lightweight core (runs everything)
└── requirements-ai.txt        # optional ML models
```

See **[docs/ARCHITECTURE.md](docs/ARCHITECTURE.md)** for the layered design and
the hybrid scoring model.

---

## ⚙️ Configuration

Copy `.env.example` → `.env` (every value has a safe default). Highlights:

```env
SECRET_KEY=change-me                # JWT signing key (set in prod!)
DATABASE_URL=sqlite+aiosqlite:///./mindnest.db
MIN_QUESTIONS=6
MAX_QUESTIONS=14
CONFIDENCE_TARGET=0.78              # stop early once confident
ENABLE_TRANSFORMER_EMOTION=true    # needs requirements-ai.txt
ENABLE_EMBEDDINGS=true             # needs requirements-ai.txt
ENABLE_LLM=true                    # needs Ollama running
OLLAMA_MODEL=tinyllama
```

---

## 🧪 Testing

```bash
pytest            # 45 tests, ~1s, no models required
```
Covers auth, the full adaptive assessment flow, the scoring engine,
contradiction detection, the questionnaire branching, and graceful AI
degradation.

---

## 🐳 Docker & ☁️ Deployment

```bash
docker compose up --build                # API only (rule-based, offline)
docker compose --profile ai up --build   # API + local Ollama
```
Free-tier deployment (Render / Railway / Fly.io / Firebase / GitHub Pages) and
their trade-offs: **[docs/DEPLOYMENT.md](docs/DEPLOYMENT.md)**.

---

## 📱 Flutter

A complete Dart layer — typed models, Dio client with JWT, repository with
offline-first reads + an idempotent answer outbox, and a `flutter_bloc` BLoC —
is in **[flutter_integration/](flutter_integration/README.md)**.

---

## 🗺️ Roadmap ideas

- On-device adaptive engine (true offline assessments via a Dart port).
- `pgvector` for the embedding memory at scale.
- Optional Firebase Auth bridge.
- Richer clinically-informed question banks (with professional review).

## 📄 License & ethics

Open-source models and libraries retain their own licenses. MindNest handles
**sensitive emotional data** — keep it local, encrypt at rest in production,
and always present the not-a-medical-device disclaimer to users.
