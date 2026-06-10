# Deployment Guide

MindNest is designed to run **free**. The recommended setup is local-first;
the cloud options below all have usable free tiers. Pick based on whether you
need the LLM layer (which wants more RAM than most free tiers offer).

> **Key constraint:** the transformer + LLM layers need RAM. Free tiers
> typically give 256–512 MB, which is enough for the **rule-based engine**
> (the default) but *not* for PyTorch/Ollama. So: deploy the lightweight core
> to the cloud, and run the heavy AI locally — or pay for a bigger instance.

---

## 0. Localhost (recommended for full features)

```bash
python -m venv .venv && source .venv/bin/activate
pip install -r requirements.txt          # core (always)
pip install -r requirements-ai.txt       # optional: transformer + embeddings
python -m scripts.seed_demo              # optional demo data
uvicorn app.main:app --reload
```
Open <http://localhost:8000/docs>. Add Ollama (see `OLLAMA_SETUP.md`) for the
LLM summaries. **This is the only setup that gives you 100% of the features
for free**, because the models run on your own hardware.

**Limitations:** only reachable on your machine/LAN; not public.

---

## 1. Docker (anywhere)

```bash
docker compose up --build                # API only
docker compose --profile ai up --build   # API + Ollama
```
SQLite persists in the `mindnest_data` volume. Portable to any VPS.

---

## 2. Render (free tier)

1. Push the repo to GitHub.
2. New → **Web Service** → connect the repo.
3. Settings:
   - **Build:** `pip install -r requirements.txt`
   - **Start:** `uvicorn app.main:app --host 0.0.0.0 --port $PORT`
   - **Env:** set `SECRET_KEY`; leave AI flags `false` (free tier RAM).
4. Add a **Disk** (1 GB) mounted at `/data` and set
   `DATABASE_URL=sqlite+aiosqlite:////data/mindnest.db` so SQLite survives deploys.

**Limitations:** 512 MB RAM (no torch/Ollama); free services **spin down when
idle** (cold starts ~30–60 s); without a persistent disk the SQLite file is
ephemeral.

---

## 3. Railway (free trial / hobby)

1. `railway init` (or use the dashboard) and link the GitHub repo.
2. Start command: `uvicorn app.main:app --host 0.0.0.0 --port $PORT`.
3. Add a **Volume** for `/data` and point `DATABASE_URL` at it.
4. For real durability/scale, add the Railway **Postgres** plugin and set
   `DATABASE_URL=postgresql+asyncpg://...` — no code changes needed (you'll
   also need `pip install asyncpg`).

**Limitations:** trial credits are time/usage limited; RAM still too small for
the heavy AI layers.

---

## 4. Fly.io (free allowances)

1. `fly launch` (generates `fly.toml`; uses the included `Dockerfile`).
2. Create a volume and mount it:
   ```bash
   fly volumes create mindnest_data --size 1
   ```
   ```toml
   [mounts]
     source = "mindnest_data"
     destination = "/data"
   ```
3. `fly secrets set SECRET_KEY=...` and set
   `DATABASE_URL=sqlite+aiosqlite:////data/mindnest.db`.
4. `fly deploy`.

**Limitations:** small shared-CPU VMs (good for the core, not for PyTorch);
free allowance is capped; scale-to-zero adds cold starts. Fly *can* run a
bigger paid VM with Ollama if you want full features in the cloud.

---

## 5. Firebase Hosting (frontend only)

Firebase Hosting serves **static** assets — use it for a **Flutter Web** build
of the MindNest app, not the Python API.
```bash
flutter build web
firebase init hosting        # public dir: build/web
firebase deploy
```
Point the Flutter `baseUrl` at your API host (Render/Railway/Fly). Optionally
use **Firebase Auth** on the client and verify tokens server-side (out of scope
for the MVP, which ships its own JWT auth).

**Limitations:** static only — cannot host the FastAPI backend.

---

## 6. GitHub Pages (docs / frontend only)

Host this `docs/` folder or a Flutter Web build as a static site:
- Repo **Settings → Pages →** deploy from `main` `/docs`, **or**
- a GitHub Action that builds Flutter Web and publishes `build/web`.

**Limitations:** static only; no backend, no server-side env vars/secrets.

---

## Choosing

| Need | Best option |
| --- | --- |
| All features (transformer + LLM), free | **Localhost** (+ Ollama) |
| Public API, free, light (rule-based) | **Render / Fly.io** core only |
| Public API + durable DB | Railway/Fly + **Postgres** |
| Public web UI | **Firebase Hosting** / **GitHub Pages** (Flutter Web) |
| Full features in the cloud | Any paid VM (≥4 GB) running `docker compose --profile ai` |

## Production checklist
- [ ] Set a strong `SECRET_KEY` (`python -c "import secrets;print(secrets.token_urlsafe(48))"`).
- [ ] Restrict `CORS_ORIGINS` to your app's domain(s).
- [ ] Use Postgres (`postgresql+asyncpg://`) + a managed backup for real users.
- [ ] Serve over HTTPS (most platforms do this automatically).
- [ ] Treat all emotional data as sensitive; review retention & privacy.
