"""Assessment templates.

A template is a thin *configuration* over the existing adaptive engine and
question bank — a focus (which dimension tags / stages to draw from) plus
length and stop tuning. It is NOT a separate questionnaire: the same engine,
scoring and persistence run underneath. The chosen template id is stored in
``Assessment.meta["template"]`` so selection stays stateless across calls.
"""
from __future__ import annotations

from app.config import settings

DEFAULT_TEMPLATE = "adaptive"

# Each config exposes only what the engine reads:
#   focus_tags    -> restrict follow-ups to questions sharing a tag (seeds kept
#                    for baseline coverage); None = whole bank.
#   allow_stages  -> restrict to question stages; None = all stages.
#   min/max_questions, confidence_target -> length + stop tuning.
TEMPLATES: dict[str, dict] = {
    "adaptive": {
        "name": "Full check-in",
        "description": "An adaptive deep check-in across every area.",
        "focus_tags": None,
        "allow_stages": None,
        "min_questions": settings.MIN_QUESTIONS,
        "max_questions": settings.MAX_QUESTIONS,
        "confidence_target": settings.CONFIDENCE_TARGET,
    },
    "daily_checkin": {
        "name": "Daily check-in",
        "description": "A quick daily snapshot of how you're doing.",
        "focus_tags": None,
        "allow_stages": ["baseline"],
        "min_questions": 3,
        "max_questions": 5,
        "confidence_target": 0.5,
    },
    "weekly_reflection": {
        "name": "Weekly reflection",
        "description": "A broader weekly look back, with space to write.",
        "focus_tags": None,
        "allow_stages": None,
        "min_questions": 6,
        "max_questions": 10,
        "confidence_target": 0.72,
    },
    "burnout": {
        "name": "Burnout check",
        "description": "Focused on workload, energy and recovery.",
        "focus_tags": ["burnout", "fatigue", "stress"],
        "allow_stages": None,
        "min_questions": 4,
        "max_questions": 8,
        "confidence_target": 0.7,
    },
    "motivation": {
        "name": "Motivation check",
        "description": "Focused on drive, interest and outlook.",
        "focus_tags": ["motivation", "happiness"],
        "allow_stages": None,
        "min_questions": 4,
        "max_questions": 8,
        "confidence_target": 0.7,
    },
    "anxiety": {
        "name": "Anxiety check",
        "description": "Focused on worry, tension and the days ahead.",
        "focus_tags": ["anxiety", "stress"],
        "allow_stages": None,
        "min_questions": 4,
        "max_questions": 8,
        "confidence_target": 0.7,
    },
}


def resolve(template: str | None) -> str:
    """Normalise a requested template id to a known one (default if unknown)."""
    if template and template in TEMPLATES:
        return template
    return DEFAULT_TEMPLATE


def config_for(template: str | None) -> dict:
    """The engine config for a template id (falls back to the default)."""
    return TEMPLATES[resolve(template)]


def catalog() -> list[dict]:
    """Public listing for ``GET /assessment/templates``."""
    out = []
    for tid, cfg in TEMPLATES.items():
        out.append({
            "id": tid,
            "name": cfg["name"],
            "description": cfg["description"],
            "min_questions": cfg["min_questions"],
            "max_questions": cfg["max_questions"],
            "focus": cfg["focus_tags"] or [],
        })
    return out
