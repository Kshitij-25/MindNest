"""Per-user feature flags.

Flags live in ``User.settings["feature_flags"]`` (a JSON map). The catalogue
and defaults are defined here so the backend can *respect* them server-side
(e.g. skip background journal analysis when ``enable_journal_ai`` is off, or
suppress notifications). The client toggles them via ``PATCH /settings``.

Wire keys are camelCase (``enableJournalAi``); we store/read snake_case keys and
translate at the schema boundary, but accept either on input.
"""
from __future__ import annotations

# flag_key -> default value
DEFAULT_FLAGS: dict[str, bool] = {
    "enable_coach": True,
    "enable_journal_ai": True,
    "enable_weekly_report": True,
    "enable_recommendations": True,
    "daily_reminder": True,
    "notifications": True,
    "biometric_lock": False,
}

# Non-boolean preferences that also live under settings (not feature flags).
DEFAULT_PREFS: dict[str, object] = {
    "theme": "system",   # system | light | dark
}


def merged_flags(settings: dict | None) -> dict[str, bool]:
    """Defaults overlaid with whatever the user has saved."""
    saved = (settings or {}).get("feature_flags") or {}
    return {k: bool(saved.get(k, v)) for k, v in DEFAULT_FLAGS.items()}


def flag_enabled(settings: dict | None, key: str) -> bool:
    return merged_flags(settings).get(key, DEFAULT_FLAGS.get(key, False))
