"""Local LLM reasoning via Ollama (optional).

Talks to a locally-running Ollama server (default http://localhost:11434)
over its HTTP API. Used to turn the structured mood profile into a warm,
human summary. Completely optional: if Ollama isn't running or the call
fails/times out, callers fall back to a deterministic template summary.

No API keys, no cloud — the model runs on the user's machine.
"""
from __future__ import annotations

import logging
import re

import httpx

from app.config import settings

logger = logging.getLogger("mindnest.ai.llm")

# Some local models (e.g. qwen "thinking" variants) wrap private reasoning in
# <think>...</think>. Strip it so callers get only the final answer.
_THINK_RE = re.compile(r"<think>.*?</think>", re.DOTALL | re.IGNORECASE)


class OllamaClient:
    def __init__(self) -> None:
        self.base_url = settings.OLLAMA_BASE_URL.rstrip("/")
        self.model = settings.OLLAMA_MODEL
        self.timeout = settings.OLLAMA_TIMEOUT
        self.enabled = settings.ENABLE_LLM

    async def health(self) -> bool:
        """Is an Ollama server reachable right now?"""
        if not self.enabled:
            return False
        try:
            async with httpx.AsyncClient(timeout=5.0) as client:
                r = await client.get(f"{self.base_url}/api/tags")
                return r.status_code == 200
        except Exception:
            return False

    async def generate(self, prompt: str, system: str | None = None) -> str | None:
        """Return generated text, or None on any failure (never raises)."""
        if not self.enabled:
            return None
        payload: dict = {
            "model": self.model,
            "prompt": prompt,
            "stream": False,
            "options": {"temperature": 0.6, "num_predict": 320},
        }
        if system:
            payload["system"] = system
        try:
            async with httpx.AsyncClient(timeout=self.timeout) as client:
                r = await client.post(f"{self.base_url}/api/generate", json=payload)
                r.raise_for_status()
                data = r.json()
                text = _THINK_RE.sub("", data.get("response") or "").strip()
                return text or None
        except Exception as exc:
            logger.info("Ollama generate unavailable (%s).", exc.__class__.__name__)
            return None


ollama = OllamaClient()
