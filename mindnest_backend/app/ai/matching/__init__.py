"""Professional matching logic.

The :mod:`engine` is a pure, deterministic layer that maps a user's emotional
signals (dimension scores, burnout risk, goals, focus areas) onto a ranked
list of professionals. The service layer
(:mod:`app.services.professional_matching`) gathers the signals from MVP 1 and
loads the candidate professionals.
"""
from app.ai.matching.engine import rank_professionals

__all__ = ["rank_professionals"]
