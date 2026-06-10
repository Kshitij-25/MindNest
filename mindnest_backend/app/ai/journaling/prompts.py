"""Journaling prompts.

Two unrelated kinds of "prompt" live here:

* ``WRITING_PROMPTS`` — suggestions shown to the *user* to seed an entry
  (served by ``GET /journal/prompts``).
* ``build_summary_prompt`` / ``SUMMARY_SYSTEM`` — the instruction given to the
  local LLM to write a short reflection on an entry (used by the analyzer).
"""
from __future__ import annotations

WRITING_PROMPTS: dict[str, list[str]] = {
    "guided": [
        "What's taking up the most space in your mind today?",
        "Describe a moment today that affected how you felt.",
        "What do you need more of this week — and what's one step toward it?",
        "If today had a title, what would it be and why?",
    ],
    "gratitude": [
        "Name three things that went okay today, however small.",
        "Who or what are you grateful for right now?",
        "What's something your body or mind did for you today?",
        "Recall a small kindness — given or received.",
    ],
    "reflection": [
        "What drained you today, and what restored you?",
        "What would you tell a friend who had the day you just had?",
        "What pattern have you noticed in how you've been feeling?",
        "What's one thing you'd like to let go of before tomorrow?",
    ],
    "free": [
        "Write freely — whatever is on your mind, no structure needed.",
    ],
}


def prompts_for(kind: str | None) -> list[str]:
    if kind and kind in WRITING_PROMPTS:
        return WRITING_PROMPTS[kind]
    # Default: a mix across kinds.
    out: list[str] = []
    for k in ("guided", "reflection", "gratitude"):
        out.extend(WRITING_PROMPTS[k][:2])
    return out


SUMMARY_SYSTEM = (
    "You are MindNest, a warm wellbeing companion. You are not a clinician and "
    "never diagnose. Reply with ONLY 2 to 3 supportive sentences written directly "
    "to the person as 'you'. No lists, no headings, no preamble, no sign-off. "
    "Reflect back what they wrote, gently name the feeling, and offer one small, "
    "kind observation. Keep a calm, non-alarming tone."
)


def build_summary_prompt(text: str, feelings: str, topics: list[str]) -> str:
    topic_clause = f" They mention {', '.join(topics)}." if topics else ""
    feeling_clause = f" They seem to be feeling {feelings}." if feelings else ""
    return (
        f"A person wrote this journal entry:\n\n\"{text[:900]}\"\n"
        f"{feeling_clause}{topic_clause}\n\n"
        "Write your short supportive reflection to them now:"
    )
