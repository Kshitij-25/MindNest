"""Journal analysis — the background pipeline.

Pure-ish analysis (no DB): given entry text, produce the structured fields the
``journal_analysis`` row stores. Dimensions come from the always-on text
pipeline; topics from keyword detection; stressors/wins/concerns/suggestions
are derived deterministically (reusing the recommendation engine); the prose
summary uses the local LLM when available, with a deterministic fallback.

A journal entry is a *single* short signal, so we read the pipeline's dimension
**deltas** directly (how much evidence the text gives for each dimension)
rather than anchoring them to the assessment baselines — a few negative deltas
shouldn't be drowned out by untouched positive dimensions sitting at baseline.
"""
from __future__ import annotations

from app.ai import pipeline
from app.ai.journaling import prompts
from app.ai.journaling import topics as topic_detect
from app.ai.llm import ollama
from app.ai.recommendations import engine as rec_engine
from app.core.dimensions import (
    BASELINES,
    DIMENSION_LABELS,
    DIMENSIONS,
    HAPPINESS,
    MOTIVATION,
    POSITIVE_DIMENSIONS,
)
from app.services import scoring

# Delta thresholds tuned for a single short entry (points of lexical evidence).
_CONCERN_DELTA = 12.0
_WIN_DELTA = 8.0
_LOW_POS_DELTA = -10.0
# Gain applied to deltas when synthesising a score state for the rec engine.
# Higher than 1 because a single entry's lexical evidence is modest, yet the
# engine's thresholds are calibrated for full (multi-answer) assessments.
_JOURNAL_GAIN = 3.0
# Untouched positive dims are held just above the engine's low-positive trigger
# (50) so we don't suggest "low motivation" help for an entry that never
# mentioned it — without inflating it to a falsely upbeat reading.
_NEUTRAL_POSITIVE = 55.0


def _concerns(deltas: dict) -> list[str]:
    negs = sorted(
        ((d, deltas.get(d, 0.0)) for d in DIMENSIONS
         if d not in POSITIVE_DIMENSIONS and deltas.get(d, 0.0) >= _CONCERN_DELTA),
        key=lambda p: p[1], reverse=True,
    )
    out = [DIMENSION_LABELS[d] for d, _ in negs]
    for pd in (MOTIVATION, HAPPINESS):
        if deltas.get(pd, 0.0) <= _LOW_POS_DELTA:
            out.append(f"Low {DIMENSION_LABELS[pd].lower()}")
    return out


def _wins(deltas: dict) -> list[str]:
    out = []
    if deltas.get(HAPPINESS, 0.0) >= _WIN_DELTA:
        out.append("A sense of positivity")
    if deltas.get(MOTIVATION, 0.0) >= _WIN_DELTA:
        out.append("Feeling motivated")
    return out


def _emotion(deltas: dict) -> str | None:
    best_neg, best_neg_v = None, 0.0
    for d in DIMENSIONS:
        if d not in POSITIVE_DIMENSIONS and deltas.get(d, 0.0) > best_neg_v:
            best_neg, best_neg_v = d, deltas[d]
    best_pos, best_pos_v = None, 0.0
    for d in (HAPPINESS, MOTIVATION):
        if deltas.get(d, 0.0) > best_pos_v:
            best_pos, best_pos_v = d, deltas[d]
    if best_neg is not None and best_neg_v >= _CONCERN_DELTA and best_neg_v >= best_pos_v:
        return DIMENSION_LABELS[best_neg]
    if best_pos is not None and best_pos_v >= _WIN_DELTA:
        return DIMENSION_LABELS[best_pos]
    return None


def _engine_state(deltas: dict) -> tuple[dict, dict]:
    """Synthesise a (scores, derived) state for the recommendation engine.

    Negative evidence is amplified onto the baseline so a clearly-distressed
    entry trips the engine's thresholds; positive dimensions the text never
    touched are held neutral so we don't suggest "low motivation" help for an
    entry that simply didn't mention motivation.
    """
    scores = dict(BASELINES)
    for d, v in deltas.items():
        if d in scores:
            scores[d] = max(0.0, min(100.0, scores[d] + v * _JOURNAL_GAIN))
    for pd in (HAPPINESS, MOTIVATION):
        if abs(deltas.get(pd, 0.0)) < 0.5:  # untouched by the text
            scores[pd] = _NEUTRAL_POSITIVE
    derived = scoring._derived_metrics(scores)
    return scores, derived


def _mood_phrase(concerns: list[str], wins: list[str], emotion: str | None) -> str:
    """A short reading for the summary, derived straight from the signal."""
    if concerns:
        return f"weighed down by {concerns[0].lower()}"
    if wins:
        return "positive and uplifted"
    if emotion:
        return f"coloured by {emotion.lower()}"
    return "fairly balanced"


def _join(items: list[str]) -> str:
    items = [i.lower() for i in items]
    if not items:
        return "a mix of things"
    if len(items) == 1:
        return items[0]
    return ", ".join(items[:-1]) + f" and {items[-1]}"


def _template_summary(mood_label: str, topic_names: list[str]) -> str:
    parts = []
    if topic_names:
        parts.append(f"You wrote about {_join(topic_names)}.")
    else:
        parts.append("Thanks for taking a moment to put this into words.")
    parts.append(f"Overall this reads as {mood_label.lower()}.")
    parts.append("Naming how you feel is a real step — be gentle with yourself today.")
    return " ".join(parts)


async def _summary(text: str, feelings: str, topic_names: list[str], mood_label: str) -> tuple[str, str]:
    if ollama.enabled:
        out = await ollama.generate(
            prompts.build_summary_prompt(text, feelings, topic_names),
            system=prompts.SUMMARY_SYSTEM,
        )
        if out:
            return out, ollama.model
    return _template_summary(mood_label, topic_names), "template"


async def analyze(text: str, *, focus: list[str] | None = None) -> dict:
    """Analyse one journal entry into the structured ``journal_analysis`` shape."""
    text = (text or "").strip()
    nlp = pipeline.analyze_text(text, focus=focus)
    deltas = nlp.get("dimensions") or {}
    sources = list(nlp.get("sources") or [])
    if "rule_based" not in sources:
        sources.append("rule_based")

    detected = topic_detect.detect_topics(text)
    topic_names = [t["name"] for t in detected]

    concerns = _concerns(deltas)
    wins = _wins(deltas)
    stressors = topic_names if concerns else []

    top = nlp.get("top_emotion")
    emotion = (top or {}).get("label") if top else _emotion(deltas)

    themes: list[str] = []
    for t in topic_names + concerns + wins:
        if t not in themes:
            themes.append(t)
    themes = themes[:5]

    scores, derived = _engine_state(deltas)
    suggestions = [r["title"] for r in rec_engine.recommend(scores, derived, limit=3)]

    mood_phrase = _mood_phrase(concerns, wins, emotion)
    feelings = _join(concerns or wins or ([emotion] if emotion else ["okay"]))
    summary, model = await _summary(text, feelings, topic_names, mood_phrase)

    return {
        "emotion": emotion,
        "dimensions": deltas,
        "summary": summary,
        "topics": detected,
        "themes": themes,
        "stressors": stressors,
        "wins": wins,
        "concerns": concerns,
        "suggestions": suggestions,
        "sources": sources,
        "model": model,
    }
