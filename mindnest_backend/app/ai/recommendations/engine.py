"""The recommendation engine — pure, deterministic, offline.

Maps a 0..100 dimension score vector (+ the derived metrics from
``scoring.aggregate``) onto a ranked list of wellness nudges. No I/O, no
models — just rules, so it always works and is trivially unit-testable. The
local LLM may *enrich the copy* later (in the service layer); the set of
recommendations and their floor scores come from here.

Each recommendation is a plain dict::

    {
      "kind":   one of RECOMMENDATION_KINDS,
      "title":  short imperative title,
      "body":   one or two supportive sentences,
      "score":  0..100 salience (higher = surface first),
      "reason": why this was suggested (shown as a subtitle),
      "source": {"dimension"|"signal": ..., "value": ...},  # provenance
    }
"""
from __future__ import annotations

from app.core.dimensions import (
    ANGER,
    ANXIETY,
    BURNOUT,
    FATIGUE,
    HAPPINESS,
    INSTABILITY,
    LONELINESS,
    MOTIVATION,
    POSITIVE_DIMENSIONS,
    SADNESS,
    STRESS,
)

RECOMMENDATION_KINDS = [
    "journal_prompt",
    "reflection",
    "breathing",
    "sleep",
    "habit",
    "mindfulness",
]


def _salience(scores: dict[str, float], dim: str) -> float:
    """How notable is this dimension? Valence-aware (low positive == notable)."""
    v = float(scores.get(dim, 0.0))
    return (100.0 - v) if dim in POSITIVE_DIMENSIONS else v


def recommend(
    scores: dict[str, float],
    derived: dict | None = None,
    *,
    limit: int = 6,
) -> list[dict]:
    """Return ranked recommendations for a score state.

    ``scores`` is a ``dim -> 0..100`` map (e.g. ``MoodProfile.dimensions``);
    ``derived`` is the ``scoring`` derived-metrics block (``burnout_risk`` …).
    """
    s = scores or {}
    derived = derived or {}
    out: list[dict] = []

    def add(kind: str, title: str, body: str, base: float, reason: str, source: dict):
        out.append({
            "kind": kind,
            "title": title,
            "body": body,
            "score": round(max(0.0, min(100.0, base)), 1),
            "reason": reason,
            "source": source,
        })

    burnout_risk = float(derived.get("burnout_risk", 0.0))

    # ---- stress ----
    if _salience(s, STRESS) >= 50:
        v = s[STRESS]
        add("breathing", "Two minutes of box breathing",
            "Breathe in for 4, hold for 4, out for 4, hold for 4 — four slow "
            "rounds. It nudges your nervous system out of fight-or-flight.",
            v + 4, f"Stress is sitting around {v:.0f}/100.",
            {"dimension": STRESS, "value": v})
        add("reflection", "Name what's pressing",
            "Jot the single thing weighing on you most right now, then one small "
            "step you could take on it today.",
            v - 4, "Putting pressure into words tends to shrink it.",
            {"dimension": STRESS, "value": v})

    # ---- anxiety ----
    if _salience(s, ANXIETY) >= 50:
        v = s[ANXIETY]
        add("breathing", "Ground with 5-4-3-2-1",
            "Name 5 things you see, 4 you can touch, 3 you hear, 2 you smell, 1 "
            "you taste. A quick anchor when worry spins ahead.",
            v + 2, f"Anxiety is elevated ({v:.0f}/100).",
            {"dimension": ANXIETY, "value": v})
        add("journal_prompt", "Write the worry down",
            "What's the worry, and what's actually within your control about it? "
            "Separating the two often loosens its grip.",
            v - 6, "Externalising worries reduces rumination.",
            {"dimension": ANXIETY, "value": v})

    # ---- burnout / fatigue / sleep ----
    if burnout_risk >= 50:
        add("sleep", "Protect your recovery tonight",
            "Pick one wind-down: screens off 30 minutes early, a warm shower, or "
            "lights out 20 minutes sooner. Recovery is the antidote to burnout.",
            burnout_risk, f"Burnout risk looks {derived.get('burnout_label', 'elevated')}.",
            {"signal": "burnout_risk", "value": burnout_risk})
        add("habit", "Schedule one real break",
            "Block a 15-minute, no-work pause in your day — a walk, tea, anything "
            "that isn't a screen. Small, repeatable, restorative.",
            burnout_risk - 8, "Regular micro-breaks slow burnout's build-up.",
            {"signal": "burnout_risk", "value": burnout_risk})
    if _salience(s, FATIGUE) >= 55:
        v = s[FATIGUE]
        add("sleep", "A gentler evening",
            "Your energy reads low. Try a consistent wind-down tonight and aim "
            "for an earlier night — even 30 minutes helps.",
            v - 2, f"Emotional fatigue is high ({v:.0f}/100).",
            {"dimension": FATIGUE, "value": v})

    # ---- sadness ----
    if _salience(s, SADNESS) >= 50:
        v = s[SADNESS]
        add("journal_prompt", "Three small good things",
            "List three things — however small — that went okay today, and why. "
            "Gratitude won't erase low mood, but it widens the lens.",
            v, f"Sadness is showing up ({v:.0f}/100).",
            {"dimension": SADNESS, "value": v})
        add("reflection", "Be your own friend",
            "Write what you'd say to a friend feeling exactly how you feel now. "
            "Then read it back to yourself.",
            v - 6, "Self-compassion shifts a heavy mood more than self-criticism.",
            {"dimension": SADNESS, "value": v})

    # ---- loneliness ----
    if _salience(s, LONELINESS) >= 50:
        v = s[LONELINESS]
        add("habit", "Reach out to one person",
            "Send a single message to someone you trust — no agenda needed. "
            "One small connection can move the needle.",
            v, f"Loneliness is elevated ({v:.0f}/100).",
            {"dimension": LONELINESS, "value": v})

    # ---- anger / instability ----
    if _salience(s, ANGER) >= 50:
        v = s[ANGER]
        add("breathing", "Cool down before you act",
            "Step away for 90 seconds and breathe out longer than you breathe in. "
            "The first wave of anger passes faster than it feels.",
            v, f"Irritability is running high ({v:.0f}/100).",
            {"dimension": ANGER, "value": v})
    if _salience(s, INSTABILITY) >= 55:
        v = s[INSTABILITY]
        add("mindfulness", "Anchor to right now",
            "When feelings swing, a 3-minute body scan — feet, breath, shoulders — "
            "brings you back to steady ground.",
            v - 4, f"Mood has felt changeable ({v:.0f}/100).",
            {"dimension": INSTABILITY, "value": v})

    # ---- low motivation ----
    if _salience(s, MOTIVATION) >= 50:
        v = s[MOTIVATION]
        add("habit", "Shrink the first step",
            "Pick the smallest possible version of one task and do just that. "
            "Momentum follows action, not the other way round.",
            _salience(s, MOTIVATION), f"Motivation is low ({v:.0f}/100).",
            {"dimension": MOTIVATION, "value": v})

    # ---- low happiness ----
    if _salience(s, HAPPINESS) >= 55:
        v = s[HAPPINESS]
        add("mindfulness", "Savour one good moment",
            "Notice one pleasant thing today and stay with it for 20 seconds — "
            "really let it land. Savouring trains the brain toward the good.",
            _salience(s, HAPPINESS) - 6, f"Happiness reads low ({v:.0f}/100).",
            {"dimension": HAPPINESS, "value": v})

    # ---- maintenance fallback (nothing notably elevated) ----
    if not out:
        add("journal_prompt", "A quick check-in entry",
            "Things look fairly steady. A short journal entry — how today felt and "
            "what you'd like more of — keeps the picture sharp.",
            30.0, "No single emotion stands out right now.",
            {"signal": "baseline", "value": 0.0})
        add("mindfulness", "One mindful minute",
            "Take sixty seconds to just breathe and notice. A small habit that "
            "compounds on the steady days.",
            26.0, "Maintenance habit for a balanced week.",
            {"signal": "baseline", "value": 0.0})

    # Dedupe identical titles (keep highest score), then rank.
    best_by_title: dict[str, dict] = {}
    for r in out:
        cur = best_by_title.get(r["title"])
        if cur is None or r["score"] > cur["score"]:
            best_by_title[r["title"]] = r
    ranked = sorted(best_by_title.values(), key=lambda r: r["score"], reverse=True)
    return ranked[:limit]
