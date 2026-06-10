"""Discover & Learn library — curated, MindNest-authored wellness content
(read-only, no social). camelCase out."""
from __future__ import annotations

from pydantic import Field

from app.schemas.common import CamelModel


class ArticleOut(CamelModel):
    id: str
    category: str          # Wellness Article | AI Insight | Mood Education | …
    topic: str
    image: bool = False
    read_minutes: int = 3
    source: str = "MindNest Library"
    title: str
    body: str
    prompt: bool = False   # is this a reflection prompt?


class ArticleListOut(CamelModel):
    articles: list[ArticleOut] = Field(default_factory=list)
