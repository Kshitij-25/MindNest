"""The adaptive questionnaire engine.

Selects the next question dynamically based on:
  * explicit branching (a question's ``follow_ups``),
  * running dimension scores (probe what's elevated / uncertain),
  * coverage (make sure the baseline breadth is covered early),
  * detected contradictions (inject clarifying questions),
  * skipped questions (they simply don't satisfy coverage).

Selection is *stateless*: given the set of answered questions and the
current score state it deterministically returns the next question. That
makes the API idempotent and the engine easy to test.
"""
from __future__ import annotations

import json
from functools import lru_cache
from pathlib import Path

from app.config import settings
from app.core.dimensions import DIMENSIONS, is_high
from app.services import scoring

_DATA_FILE = Path(__file__).resolve().parent.parent / "data" / "questions.json"


class QuestionBank:
    def __init__(self, questions: list[dict]) -> None:
        self._list = questions
        self._by_id = {q["id"]: q for q in questions}

    def all(self) -> list[dict]:
        return list(self._list)

    def get(self, qid: str) -> dict | None:
        return self._by_id.get(qid)

    def seeds(self) -> list[dict]:
        return [q for q in self._list if "seed" in (q.get("tags") or [])]


@lru_cache
def get_bank() -> QuestionBank:
    data = json.loads(_DATA_FILE.read_text(encoding="utf-8"))
    return QuestionBank(data["questions"])


def public_question(q: dict, reason: str | None = None) -> dict:
    """Strip scoring internals; shape for the client (matches QuestionOut)."""
    out: dict = {
        "id": q["id"],
        "text": q["text"],
        "type": q["type"],
        "dimension": q.get("dimension", "general"),
        "stage": q.get("stage", "baseline"),
        "allow_skip": q.get("allow_skip", True),
        "reason": reason,
    }
    if q["type"] in ("multiple_choice", "emoji"):
        out["options"] = [
            {"id": o["id"], "label": o["label"], "emoji": o.get("emoji")}
            for o in q.get("options", [])
        ]
    elif q["type"] == "slider":
        sl = q.get("slider", {})
        out["slider"] = {
            "min": sl.get("min", 0), "max": sl.get("max", 10),
            "step": sl.get("step", 1),
            "min_label": sl.get("min_label"), "max_label": sl.get("max_label"),
        }
    elif q["type"] in ("free_text", "journal"):
        out["placeholder"] = q.get("placeholder")
    return out


# ---- branching ---------------------------------------------------------------


def _triggered_followups(bank: QuestionBank, answers: list[dict]) -> list[str]:
    """Follow-up question ids triggered by answers, most-recent first."""
    out: list[str] = []
    for ans in answers:                      # ans = {"question_id","raw"}
        q = bank.get(ans["question_id"])
        if not q:
            continue
        raw = ans["raw"]
        for rule in q.get("follow_ups", []) or []:
            nxt = rule.get("next")
            if not nxt:
                continue
            if "if_option" in rule and raw.get("option_id") == rule["if_option"]:
                out.append(nxt)
            elif "if_gte" in rule and raw.get("value") is not None and float(raw["value"]) >= rule["if_gte"]:
                out.append(nxt)
            elif "if_lte" in rule and raw.get("value") is not None and float(raw["value"]) <= rule["if_lte"]:
                out.append(nxt)
    out.reverse()  # most recent answer's branch first
    return out


# ---- adaptive need model -----------------------------------------------------


def _resolve_cfg(config: dict | None) -> dict:
    """Merge a template config over the global defaults (None = full adaptive)."""
    c = config or {}
    focus = set(c.get("focus_tags") or []) or None
    stages = set(c.get("allow_stages") or []) or None
    return {
        "min_questions": c.get("min_questions", settings.MIN_QUESTIONS),
        "max_questions": c.get("max_questions", settings.MAX_QUESTIONS),
        "confidence_target": c.get("confidence_target", settings.CONFIDENCE_TARGET),
        "focus_tags": focus,
        "allow_stages": stages,
    }


def _in_pool(q: dict, cfg: dict) -> bool:
    """Is this question selectable under the (template) config?"""
    tags = set(q.get("tags") or [])
    if cfg["allow_stages"] is not None:
        return q.get("stage") in cfg["allow_stages"]
    if cfg["focus_tags"] is not None:
        return "seed" in tags or bool(tags & cfg["focus_tags"])
    return True


def _needs(scores: dict[str, float], confidence: dict[str, float],
           touched: set[str], count: int, cfg: dict) -> dict[str, float]:
    coverage_w = 2.6 if count < cfg["min_questions"] else 0.4
    target = cfg["confidence_target"]
    needs: dict[str, float] = {}
    for d in DIMENSIONS:
        n = 0.0
        if d not in touched:
            n += coverage_w
        if is_high(d, scores[d]):
            n += 3.0           # something notable here — dig deeper
        c = confidence.get(d, 0.0)
        if d in touched and c < target:
            n += (target - c) * 2.2
        needs[d] = n
    return needs


def _candidate_score(q: dict, needs: dict[str, float], dim_ask_count: dict[str, int]) -> float:
    targeted = scoring.targeted_dimensions(q)
    if not targeted:
        return 0.0
    base = sum(needs.get(d, 0.0) for d in targeted)
    # gentle penalty for repeatedly hammering the same dimension
    fatigue_pen = sum(0.5 * dim_ask_count.get(d, 0) for d in targeted)
    # prefer information-rich text prompts a touch when deep in the flow
    type_bonus = 0.4 if q["type"] in ("free_text", "journal") else 0.0
    return base - fatigue_pen + type_bonus


def select_next_question(
    answers: list[dict],
    state: dict,
    config: dict | None = None,
) -> tuple[dict | None, str | None]:
    """Return ``(question_dict | None, reason)``.

    ``answers``: ordered list of ``{"question_id", "raw"}``.
    ``state``: the ``scoring.aggregate(...)`` result for those answers.
    ``config``: optional template config (focus/length/stop tuning); ``None``
    runs the full adaptive flow.
    A ``None`` question means the assessment is complete.
    """
    cfg = _resolve_cfg(config)
    bank = get_bank()
    answered = {a["question_id"] for a in answers}
    count = len(answers)
    scores = state["scores"]
    confidence = state["confidence"]
    touched = set(state["touched"])
    contradictions = state.get("contradictions", [])

    # 1) Honour explicit branching first (most relevant in-context).
    #    A template's pool still governs branches, so a focused check-in
    #    (e.g. "anxiety") won't wander off into out-of-scope follow-ups.
    for qid in _triggered_followups(bank, answers):
        if qid not in answered:
            q = bank.get(qid)
            if q and _in_pool(q, cfg):
                return q, "follow-up to a previous answer"

    # 2) Resolve contradictions with a clarifying question.
    answered_clarify = sum(
        1 for a in answers
        if (bank.get(a["question_id"]) or {}).get("stage") == "clarify"
    )
    if contradictions and count >= 3 and answered_clarify < 2:
        for q in bank.all():
            if q.get("stage") == "clarify" and q["id"] not in answered:
                return q, "clarifying mixed / contradictory answers"

    # 3) Stop conditions.
    if count >= cfg["max_questions"]:
        return None, None
    enough = (
        count >= cfg["min_questions"]
        and state["overall_confidence"] >= cfg["confidence_target"]
        and not contradictions
    )
    if enough:
        return None, None

    # 4) Adaptive coverage / depth selection.
    needs = _needs(scores, confidence, touched, count, cfg)
    dim_ask_count: dict[str, int] = {}
    for a in answers:
        q = bank.get(a["question_id"])
        if q:
            for d in scoring.targeted_dimensions(q):
                dim_ask_count[d] = dim_ask_count.get(d, 0) + 1

    best: dict | None = None
    best_score = float("-inf")
    for q in bank.all():
        if q["id"] in answered or q.get("stage") == "clarify":
            continue
        if not _in_pool(q, cfg):
            continue
        sc = _candidate_score(q, needs, dim_ask_count)
        # Prefer seeds while still establishing baseline coverage.
        if count < cfg["min_questions"] and "seed" in (q.get("tags") or []):
            sc += 1.5
        if sc > best_score:
            best_score, best = sc, q

    if best is None:
        return None, None

    # If we've met the minimum and nothing is meaningfully informative, stop.
    if count >= cfg["min_questions"] and best_score <= 0.5:
        return None, None

    reason = "exploring your strongest signals" if count >= cfg["min_questions"] \
        else "building a baseline picture"
    return best, reason
