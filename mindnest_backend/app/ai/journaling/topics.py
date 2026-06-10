"""Life-topic vocabulary + keyword detection.

A small, transparent topic taxonomy used to attribute journal text to life
areas (Work, Relationships, Sleep …). ``color_key`` / ``topic_index`` mirror
the Flutter theme palette (topic0..topic4) so cards return the colour the
client expects. This same list seeds the ``topics`` reference table.
"""
from __future__ import annotations

import re

# slug, name, palette index (0..4), keywords. Several topics may share a colour.
TOPIC_VOCAB: list[dict] = [
    {"slug": "work", "name": "Work", "index": 0,
     "keywords": ["work", "job", "boss", "office", "deadline", "meeting",
                  "career", "project", "colleague", "coworker", "manager", "shift"]},
    {"slug": "relationships", "name": "Relationships", "index": 1,
     "keywords": ["partner", "boyfriend", "girlfriend", "wife", "husband",
                  "relationship", "date", "dating", "breakup", "marriage", "ex"]},
    {"slug": "family", "name": "Family", "index": 2,
     "keywords": ["family", "mom", "mum", "dad", "mother", "father", "parents",
                  "sister", "brother", "kids", "child", "son", "daughter"]},
    {"slug": "health", "name": "Health", "index": 3,
     "keywords": ["health", "sick", "ill", "doctor", "pain", "body", "weight",
                  "diet", "exercise", "gym", "workout", "injury"]},
    {"slug": "sleep", "name": "Sleep", "index": 4,
     "keywords": ["sleep", "insomnia", "nap", "bed", "awake", "rest", "slept",
                  "exhausted", "tired"]},
    {"slug": "money", "name": "Money", "index": 0,
     "keywords": ["money", "rent", "bills", "debt", "finance", "financial",
                  "salary", "pay", "afford", "budget", "savings"]},
    {"slug": "friends", "name": "Friends", "index": 1,
     "keywords": ["friend", "friends", "social", "party", "mates", "hang out"]},
    {"slug": "study", "name": "Study", "index": 2,
     "keywords": ["study", "exam", "school", "college", "university", "class",
                  "assignment", "homework", "grade", "thesis"]},
    {"slug": "self", "name": "Self & purpose", "index": 3,
     "keywords": ["myself", "purpose", "identity", "future", "goals", "meaning",
                  "confidence", "self-worth", "self worth"]},
]

_BY_SLUG = {t["slug"]: t for t in TOPIC_VOCAB}
_TOKEN_RE = re.compile(r"[a-z']+")


def color_key(index: int) -> str:
    return f"topic{index % 5}"


def _keyword_present(keyword: str, low: str, tokens: set[str]) -> bool:
    """Whole-word match for single terms; padded substring for phrases.

    Avoids false hits like "ex" inside "exhausted" — short keywords only
    match as standalone words.
    """
    if " " in keyword:
        return f" {keyword} " in f" {low} "
    return keyword in tokens


def detect_topics(text: str, *, limit: int = 4) -> list[dict]:
    """Keyword-match life topics in free text, ranked by hit count."""
    low = (text or "").lower()
    tokens = set(_TOKEN_RE.findall(low))
    scored: list[tuple[int, dict]] = []
    for t in TOPIC_VOCAB:
        hits = sum(1 for kw in t["keywords"] if _keyword_present(kw, low, tokens))
        if hits:
            scored.append((hits, t))
    scored.sort(key=lambda p: p[0], reverse=True)
    out: list[dict] = []
    seen: set[str] = set()
    for _, t in scored:
        if t["slug"] in seen:
            continue
        seen.add(t["slug"])
        out.append({
            "slug": t["slug"],
            "name": t["name"],
            "topic_index": t["index"],
            "color_key": color_key(t["index"]),
        })
        if len(out) >= limit:
            break
    return out
