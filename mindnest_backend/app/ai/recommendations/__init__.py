"""Recommendation logic.

The :mod:`engine` is a pure, deterministic rule layer mapping a dimension
score vector (+ derived metrics) onto ranked wellness nudges. The service
layer (:mod:`app.services.recommendation_service`) persists the output and
applies learned per-kind feedback weights.
"""
from app.ai.recommendations.engine import RECOMMENDATION_KINDS, recommend

__all__ = ["recommend", "RECOMMENDATION_KINDS"]
