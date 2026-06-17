"""Community feed schemas (camelCase)."""
from __future__ import annotations

from datetime import datetime

from pydantic import Field

from app.schemas.common import CamelModel


class PostCreate(CamelModel):
    type: str = Field(description="article | reflection | success_story | question | tip")
    title: str = Field(default="", max_length=200)
    body: str = ""
    tags: list[str] = Field(default_factory=list)


class PostUpdate(CamelModel):
    title: str | None = Field(default=None, max_length=200)
    body: str | None = None
    tags: list[str] | None = None


class PostOut(CamelModel):
    id: str
    author_type: str
    author_id: str
    type: str
    title: str = ""
    body: str = ""
    tags: list[str] = Field(default_factory=list)
    status: str
    like_count: int = 0
    comment_count: int = 0
    share_count: int = 0
    liked_by_me: bool = False
    saved_by_me: bool = False
    created_at: datetime
    updated_at: datetime


class CommentCreate(CamelModel):
    body: str = Field(min_length=1)


class CommentOut(CamelModel):
    id: str
    post_id: str
    author_type: str
    author_id: str
    body: str
    created_at: datetime
