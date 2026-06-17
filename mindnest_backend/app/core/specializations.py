"""Professional specialization taxonomy (MVP 2).

The canonical set of areas a professional can specialize in. Kept here (like
``core/dimensions.py``) so schemas, services and the matching engine all speak
the same vocabulary. Stored on ``Professional.specializations`` as a JSON list
of these slug keys.
"""
from __future__ import annotations

STRESS = "stress"
ANXIETY = "anxiety"
BURNOUT = "burnout"
RELATIONSHIPS = "relationships"
CAREER = "career"
SLEEP = "sleep"
MOTIVATION = "motivation"
TRAUMA = "trauma"
SELF_ESTEEM = "self_esteem"
PERSONAL_GROWTH = "personal_growth"

SPECIALIZATIONS: list[str] = [
    STRESS,
    ANXIETY,
    BURNOUT,
    RELATIONSHIPS,
    CAREER,
    SLEEP,
    MOTIVATION,
    TRAUMA,
    SELF_ESTEEM,
    PERSONAL_GROWTH,
]

SPECIALIZATION_LABELS: dict[str, str] = {
    STRESS: "Stress",
    ANXIETY: "Anxiety",
    BURNOUT: "Burnout",
    RELATIONSHIPS: "Relationships",
    CAREER: "Career",
    SLEEP: "Sleep",
    MOTIVATION: "Motivation",
    TRAUMA: "Trauma",
    SELF_ESTEEM: "Self-Esteem",
    PERSONAL_GROWTH: "Personal Growth",
}

_VALID = set(SPECIALIZATIONS)


def normalize(values: list[str] | None) -> list[str]:
    """Keep only recognised specialization keys, de-duplicated, in canon order."""
    given = {str(v).strip().lower() for v in (values or [])}
    return [s for s in SPECIALIZATIONS if s in given]


def label(key: str) -> str:
    return SPECIALIZATION_LABELS.get(key, key.replace("_", " ").title())
