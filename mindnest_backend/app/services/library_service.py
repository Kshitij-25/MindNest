"""The Discover & Learn library — a small curated set of MindNest-authored
wellness articles + a daily reflection prompt. Static, read-only content (no
DB, no social); served so the app's Learn tab is backend-driven."""
from __future__ import annotations

_ARTICLES: list[dict] = [
    {
        "id": "a1", "category": "Wellness Article", "topic": "Anxiety",
        "image": True, "read_minutes": 4, "source": "MindNest Library",
        "title": "The 3-3-3 rule for an anxious mind",
        "body": (
            "When anxiety spikes, try this gentle grounding tool. Name three "
            "things you can see, three sounds you can hear, and move three parts "
            "of your body. It won’t erase the feeling — but it gently reminds "
            "your nervous system that you’re here, and you’re safe.\n\n"
            "The goal isn’t to force calm. It’s to give your attention somewhere "
            "kinder to land."
        ),
    },
    {
        "id": "a2", "category": "AI Insight", "topic": "Sleep",
        "image": False, "read_minutes": 2, "source": "Generated for you",
        "title": "Your sleep is shaping your motivation",
        "body": (
            "We looked across your recent check-ins: on nights with under six "
            "hours of sleep, your next-day motivation runs noticeably lower. "
            "Protecting your wind-down may be one of the highest-leverage changes "
            "you can make this month."
        ),
    },
    {
        "id": "a3", "category": "Mood Education", "topic": "Mindfulness",
        "image": True, "read_minutes": 5, "source": "MindNest Library",
        "title": "Why naming an emotion softens it",
        "body": (
            "Labelling what you feel — “this is anxiety”, “this is grief” — "
            "engages the thinking brain and gently quiets the alarm system. It’s "
            "called affect labelling, and it’s one of the simplest, most reliable "
            "tools we have."
        ),
    },
    {
        "id": "a4", "category": "Habit Tip", "topic": "Stress",
        "image": False, "read_minutes": 3, "source": "MindNest Library",
        "title": "Boundaries are a form of care",
        "body": (
            "Saying no isn’t shutting someone out — it’s being honest about what "
            "you can hold. A clear boundary, kindly stated, protects the "
            "relationship as much as it protects you."
        ),
    },
    {
        "id": "a5", "category": "Reflection Prompt", "topic": "Mindfulness",
        "image": False, "read_minutes": 1, "source": "Today’s prompt",
        "prompt": True,
        "title": "What gave you a moment of calm today?",
        "body": (
            "Take sixty seconds. Picture the moment, however small. What were you "
            "doing? Who were you with? Write it down — noticing calm helps your "
            "mind find it again."
        ),
    },
]


def list_articles(*, category: str | None = None, topic: str | None = None) -> list[dict]:
    items = _ARTICLES
    if category and category != "For you":
        items = [a for a in items if a["category"] == category]
    if topic and topic != "For you":
        items = [a for a in items if a["topic"] == topic]
    return items


def get_article(article_id: str) -> dict | None:
    return next((a for a in _ARTICLES if a["id"] == article_id), None)
