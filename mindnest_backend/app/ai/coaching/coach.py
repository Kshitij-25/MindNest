"""The AI coach response layer.

Not a generic chatbot: replies are grounded in the user's current mood,
concerns, recommendations and retrieved journal memories. Uses the local LLM
when available with a supportive, explicitly non-clinical system prompt, and a
deterministic fallback that is always safe and on-topic.
"""
from __future__ import annotations

from app.ai.llm import ollama

SYSTEM = (
    "You are MindNest's wellbeing coach — warm, calm and encouraging. You are "
    "NOT a clinician and you never diagnose or give medical advice. Reply in 2 "
    "to 4 short sentences, written directly to the person as 'you'. Acknowledge "
    "what they said, gently reflect their current feelings, offer at most one "
    "small, practical suggestion, and end with a caring open question. No lists, "
    "no headings, no preamble. If they mention self-harm or crisis, gently "
    "encourage contacting a trusted person or a local helpline."
)


def _join(items: list[str]) -> str:
    items = [i.lower() for i in items if i]
    if not items:
        return ""
    if len(items) == 1:
        return items[0]
    return ", ".join(items[:-1]) + f" and {items[-1]}"


def _build_prompt(message: str, ctx: dict) -> str:
    lines = [f'The person said: "{message.strip()}"']
    if ctx.get("mood"):
        lines.append(f"Their recent overall mood reads as {ctx['mood'].lower()}.")
    if ctx.get("concerns"):
        lines.append(f"Notable feelings lately: {_join(ctx['concerns'])}.")
    if ctx.get("memories"):
        snippet = ctx["memories"][0]["snippet"]
        lines.append(f'Something they wrote before: "{snippet}".')
    if ctx.get("recommendations"):
        lines.append(f"A suggestion already offered to them: {ctx['recommendations'][0]}.")
    lines.append("\nWrite your short, supportive coaching reply now:")
    return "\n".join(lines)


def _fallback(message: str, ctx: dict) -> str:
    parts: list[str] = []
    if ctx.get("mood"):
        parts.append(f"It sounds like things have felt {ctx['mood'].lower()} lately, and I'm glad you reached out.")
    else:
        parts.append("Thank you for sharing that with me — I'm here with you.")
    if ctx.get("concerns"):
        parts.append(f"You've had {_join(ctx['concerns'])} on your mind.")
    if ctx.get("recommendations"):
        parts.append(f"One small thing that might help is to {ctx['recommendations'][0].lower()}.")
    parts.append("What feels like the most pressing thing for you right now?")
    return " ".join(parts)


async def respond(message: str, ctx: dict) -> tuple[str, str]:
    if ollama.enabled:
        out = await ollama.generate(_build_prompt(message, ctx), system=SYSTEM)
        if out:
            return out, ollama.model
    return _fallback(message, ctx), "template"
