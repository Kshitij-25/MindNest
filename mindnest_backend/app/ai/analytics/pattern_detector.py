"""Pattern detector — recurring themes, triggers and behaviour patterns.

Distinct from the timeline (which explains change over time): this finds
recurring *correlations* by cross-tabbing journal topics in difficult entries
and mood levels against logged factors. Deterministic (frequency / averages);
optional LLM phrasing can be layered later.
"""
from __future__ import annotations

from collections import Counter, defaultdict

from app.ai.journaling.topics import color_key

# Topic name -> palette index, for card colours (mirrors the topic vocab).
from app.ai.journaling.topics import TOPIC_VOCAB

_TOPIC_INDEX = {t["name"]: t["index"] for t in TOPIC_VOCAB}

_MIN_STRESSFUL = 2
_TOPIC_PCT_MIN = 34
_MIN_FACTOR_DAYS = 3
_LEVEL_DELTA_MIN = 0.5


def detect(journal_items: list[dict], mood_items: list[dict]) -> list[dict]:
    """``journal_items``: ``{concerns: bool, topics: [name]}``;
    ``mood_items``: ``{level: int, factors: [{key,label}]}``."""
    cards: list[dict] = []

    # 1) Which topics recur in *difficult* journal entries?
    stressful = [j for j in journal_items if j.get("concerns")]
    if len(stressful) >= _MIN_STRESSFUL:
        counts: Counter = Counter()
        for j in stressful:
            for name in set(j.get("topics") or []):
                counts[name] += 1
        for name, cnt in counts.most_common(3):
            pct = round(100 * cnt / len(stressful))
            if pct >= _TOPIC_PCT_MIN:
                idx = _TOPIC_INDEX.get(name, len(cards))
                cards.append({
                    "title": f"{name} & difficult days",
                    "body": f"{name} comes up in {pct}% of your tougher entries.",
                    "kind": "trigger",
                    "value": pct,
                    "topic_index": idx % 5,
                    "color_key": color_key(idx),
                })

    # 2) Does mood move with a logged factor?
    if mood_items:
        all_levels = [m["level"] for m in mood_items]
        overall = sum(all_levels) / len(all_levels)
        by_factor: dict[str, list[int]] = defaultdict(list)
        label_of: dict[str, str] = {}
        for m in mood_items:
            for f in m.get("factors") or []:
                key = f["key"] if isinstance(f, dict) else f
                label = (f.get("label") if isinstance(f, dict) else f) or key
                by_factor[key].append(m["level"])
                label_of[key] = label
        ranked = sorted(
            ((k, v) for k, v in by_factor.items() if len(v) >= _MIN_FACTOR_DAYS),
            key=lambda kv: abs(sum(kv[1]) / len(kv[1]) - overall),
            reverse=True,
        )
        for key, levels in ranked[:2]:
            avg = sum(levels) / len(levels)
            delta = avg - overall
            if abs(delta) < _LEVEL_DELTA_MIN:
                continue
            label = label_of[key]
            idx = len(cards)
            if delta < 0:
                body = f"Your mood tends to dip on days you log {label.lower()}."
            else:
                body = f"Your mood tends to lift on days you log {label.lower()}."
            cards.append({
                "title": f"{label} & your mood",
                "body": body,
                "kind": "behavior",
                "value": round(abs(delta), 1),
                "topic_index": idx % 5,
                "color_key": color_key(idx),
            })

    return cards
