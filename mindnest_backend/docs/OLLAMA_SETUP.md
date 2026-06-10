# Local LLM Setup (Ollama)

MindNest uses [Ollama](https://ollama.com) for the **optional** local-LLM
reasoning layer that turns a mood profile into a warm, human summary.
Everything runs on your machine — no API keys, no cloud, no cost.

> MindNest works **without** Ollama. If it isn't running, summaries fall back
> to a deterministic template. Ollama just makes them more natural.

---

## 1. Install

### macOS
Use the **official app** (self-contained — it bundles the inference runner):
```bash
brew install --cask ollama-app   # or download from https://ollama.com
open -a Ollama                    # starts the server on http://localhost:11434
```
The app starts (and auto-restarts) the server in the menu bar.

> ⚠️ Avoid the Homebrew **formula** `brew install ollama` on some versions
> (e.g. 0.30.0): its bottle can be missing the `llama-server` binary, so the
> API serves but `/api/generate` returns HTTP 500. The cask above doesn't
> have this problem. Models live in `~/.ollama` and survive either install.

### Linux
```bash
curl -fsSL https://ollama.com/install.sh | sh
# systemd starts it; otherwise:
ollama serve
```

### Windows
1. Download the installer from <https://ollama.com/download>.
2. Run it — Ollama runs in the background and serves `http://localhost:11434`.
3. Use **PowerShell** or **Command Prompt** for the `ollama` commands below.

---

## 2. Pull a model

```bash
ollama pull tinyllama        # ~640 MB  — fastest, the MindNest default
# alternatives:
ollama pull phi3             # ~2.3 GB  — better quality, still light
ollama pull llama3.2:1b      # ~1.3 GB  — strong tiny model
ollama pull mistral          # ~4.1 GB  — best quality (needs more RAM)
```

Tell MindNest which one to use (in `.env`):
```env
ENABLE_LLM=true
OLLAMA_MODEL=tinyllama
OLLAMA_BASE_URL=http://localhost:11434
```

Quick test:
```bash
ollama run tinyllama "Write one supportive sentence about a stressful week."
curl http://localhost:11434/api/tags        # MindNest uses this for health checks
```

---

## 3. Model / RAM guide

| Model | Download | RAM (4-bit) | Speed (CPU) | Quality |
| --- | --- | --- | --- | --- |
| `tinyllama` | ~0.6 GB | ~2 GB | ⚡⚡⚡ | ★★ |
| `llama3.2:1b` | ~1.3 GB | ~3 GB | ⚡⚡⚡ | ★★★ |
| `phi3` (mini) | ~2.3 GB | ~4 GB | ⚡⚡ | ★★★★ |
| `mistral` 7B | ~4.1 GB | ~8 GB | ⚡ | ★★★★ |

Rule of thumb: have **~2× the model's download size** free in RAM. On 8 GB
machines stick to `tinyllama` / `llama3.2:1b` / `phi3`.

### Quantization
Ollama ships **4-bit quantized** (`Q4_K_M`) weights by default — the sweet
spot for CPU. To trade size for quality:
```bash
ollama pull phi3:mini-4k-instruct-q4_K_M   # default-ish, balanced
ollama pull mistral:7b-instruct-q3_K_S     # smaller, lower quality
ollama pull mistral:7b-instruct-q5_K_M     # larger, higher quality
```

### CPU optimization
- Close other heavy apps; LLM inference is memory-bandwidth bound.
- Limit threads if the machine becomes unresponsive:
  ```bash
  OLLAMA_NUM_THREADS=4 ollama serve
  ```
- Keep the model warm: the first request loads weights (slow); later ones are
  fast. MindNest's `OLLAMA_TIMEOUT` (default 45s) covers the cold start.
- No GPU needed. If you *have* an Apple Silicon GPU or NVIDIA card, Ollama
  uses it automatically.

---

## 4. Using Ollama from Docker Compose

The bundled `docker-compose.yml` has an `ollama` service behind the `ai` profile:
```bash
docker compose --profile ai up --build
docker exec -it mindnest-ollama ollama pull tinyllama
```
The API container reaches it at `http://ollama:11434` (already configured).

---

## 5. Troubleshooting

| Symptom | Fix |
| --- | --- |
| Summaries always say `summary_source: template` | Ollama not running, or model not pulled. Check `curl http://localhost:11434/api/tags`. |
| First summary is slow then fine | Cold-start weight load — expected. |
| `GET /api/v1/ai/status` → `"reachable": false` | Start `ollama serve`; confirm `OLLAMA_BASE_URL`. |
| Out of memory / killed | Use a smaller model or lower quantization. |
