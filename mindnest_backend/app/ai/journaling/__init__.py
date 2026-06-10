"""Journaling AI: text analysis, topic detection and writing prompts."""
from app.ai.journaling.analyzer import analyze
from app.ai.journaling.prompts import prompts_for
from app.ai.journaling.topics import detect_topics

__all__ = ["analyze", "prompts_for", "detect_topics"]
