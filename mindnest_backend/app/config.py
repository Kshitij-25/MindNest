"""Central application configuration (pydantic-settings).

All settings can be overridden via environment variables or a `.env`
file (see `.env.example`). Every field has a safe default so the app
boots with zero configuration.
"""
from __future__ import annotations

from functools import lru_cache

from pydantic import field_validator
from pydantic_settings import BaseSettings, SettingsConfigDict


class Settings(BaseSettings):
    model_config = SettingsConfigDict(
        env_file=".env", env_file_encoding="utf-8", extra="ignore"
    )

    # ---- App ----
    APP_NAME: str = "MindNest"
    ENV: str = "development"
    DEBUG: bool = True
    API_PREFIX: str = "/api/v1"

    # ---- Security / JWT ----
    SECRET_KEY: str = "dev-insecure-change-me-please-0000000000000000000000"
    ALGORITHM: str = "HS256"
    ACCESS_TOKEN_EXPIRE_MINUTES: int = 60 * 24 * 7  # 7 days
    REFRESH_TOKEN_EXPIRE_MINUTES: int = 60 * 24 * 30  # 30 days

    # ---- Demo / seeding ----
    SEED_DEMO_CONTENT: bool = True  # seed topics + a demo user at startup (dev)

    # ---- Database ----
    DATABASE_URL: str = "sqlite+aiosqlite:///./mindnest.db"

    # ---- CORS ----
    CORS_ORIGINS: str = "*"

    # ---- Adaptive questionnaire engine ----
    MIN_QUESTIONS: int = 6
    MAX_QUESTIONS: int = 14
    CONFIDENCE_TARGET: float = 0.78

    # ---- Optional AI layers ----
    ENABLE_TRANSFORMER_EMOTION: bool = True
    ENABLE_EMBEDDINGS: bool = True
    EMOTION_MODEL: str = "j-hartmann/emotion-english-distilroberta-base"
    EMBEDDING_MODEL: str = "sentence-transformers/all-MiniLM-L6-v2"

    # ---- Optional local LLM (Ollama) ----
    ENABLE_LLM: bool = True
    OLLAMA_BASE_URL: str = "http://localhost:11434"
    OLLAMA_MODEL: str = "tinyllama"
    OLLAMA_TIMEOUT: int = 45

    @property
    def cors_origins_list(self) -> list[str]:
        if self.CORS_ORIGINS.strip() == "*":
            return ["*"]
        return [o.strip() for o in self.CORS_ORIGINS.split(",") if o.strip()]

    @field_validator("CONFIDENCE_TARGET")
    @classmethod
    def _clamp_conf(cls, v: float) -> float:
        return max(0.0, min(1.0, v))


@lru_cache
def get_settings() -> Settings:
    """Cached settings singleton."""
    return Settings()


settings = get_settings()
