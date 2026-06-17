"""The referral engine — pure, deterministic, offline.

Decides whether MindNest should *suggest* human professional support based on a
user's emotional signals. Signals come from MVP 1 (burnout risk, dimensions,
anxiety trend) plus an explicit user request flag.

Hard rules, by design:
  * It NEVER diagnoses and NEVER claims medical certainty.
  * Its only output is a suggestion + the most relevant specializations.

Returns::

    {
      "should_suggest": bool,
      "severity": "none" | "low" | "moderate" | "high",
      "reasons": [str],                       # plain-language, non-clinical
      "recommended_specializations": [str],   # specialization slug keys
    }
"""
from __future__ import annotations

from app.core import specializations as spec


def evaluate(signals: dict) -> dict:
    dims = signals.get("dimensions") or {}
    burnout_risk = float(signals.get("burnout_risk") or 0.0)
    # Absent dimensions read as neutral, never as a trigger: a missing positive
    # dimension (e.g. motivation) must NOT look like "rock-bottom" (0).
    anxiety = float(dims.get("anxiety", 0.0))
    motivation = float(dims.get("motivation", 50.0))
    instability = float(dims.get("instability", 0.0))
    sadness = float(dims.get("sadness", 0.0))
    persistent_anxiety = bool(signals.get("persistent_anxiety"))
    user_requested = bool(signals.get("user_requested"))

    reasons: list[str] = []
    specs: list[str] = []
    weight = 0

    if burnout_risk >= 55:
        reasons.append("Your burnout risk has been running high recently.")
        specs += [spec.BURNOUT, spec.STRESS]
        weight += 2
    elif burnout_risk >= 45:
        reasons.append("Your burnout risk has been building.")
        specs += [spec.BURNOUT]
        weight += 1

    if anxiety >= 55:
        if persistent_anxiety:
            reasons.append("Anxiety has stayed elevated across several check-ins.")
            weight += 2
        else:
            reasons.append("Anxiety has been elevated lately.")
            weight += 1
        specs += [spec.ANXIETY]

    if motivation <= 25:
        reasons.append("Motivation has been persistently low.")
        specs += [spec.MOTIVATION, spec.CAREER]
        weight += 1

    if instability >= 55:
        reasons.append("Your mood has felt changeable.")
        specs += [spec.TRAUMA, spec.SELF_ESTEEM]
        weight += 1

    if sadness >= 60:
        reasons.append("Low mood has been showing up strongly.")
        specs += [spec.SELF_ESTEEM, spec.PERSONAL_GROWTH]
        weight += 1

    if user_requested:
        weight += 2
        if not reasons:
            reasons.append("You asked to explore talking with a professional.")

    should = weight >= 1
    if weight >= 4:
        severity = "high"
    elif weight >= 2:
        severity = "moderate"
    elif weight >= 1:
        severity = "low"
    else:
        severity = "none"

    return {
        "should_suggest": should,
        "severity": severity,
        "reasons": reasons,
        "recommended_specializations": spec.normalize(specs),
    }
