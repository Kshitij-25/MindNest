"""AI coaching: context assembly + grounded response generation."""
from app.ai.coaching.coach import respond
from app.ai.coaching.context import build as build_context

__all__ = ["respond", "build_context"]
