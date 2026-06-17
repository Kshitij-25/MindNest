"""AI → human support handoff (referral) logic.

The :mod:`engine` is a pure, deterministic evaluator: given a user's emotional
signals it decides whether to *suggest* (never prescribe) human support and
which specializations are most relevant. It never diagnoses and never claims
medical certainty — the copy lives in the service layer
(:mod:`app.services.referral_service`).
"""
from app.ai.referral.engine import evaluate

__all__ = ["evaluate"]
