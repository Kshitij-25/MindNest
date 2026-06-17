"""Community feed (MVP 2, Phase B).

Posts can be authored by either a user or a professional (``author_type``).
Likes and saves use a generic (``actor_type``, ``actor_id``) pair so both
identity spaces can interact. ``status`` makes the feed moderation-ready.
"""
from __future__ import annotations

from datetime import datetime

from sqlalchemy import (
    JSON,
    DateTime,
    ForeignKey,
    Integer,
    String,
    Text,
    UniqueConstraint,
)
from sqlalchemy.orm import Mapped, mapped_column

from app.core.utils import new_id, utcnow
from app.database import Base


class PostType:
    ARTICLE = "article"
    REFLECTION = "reflection"
    SUCCESS_STORY = "success_story"
    QUESTION = "question"
    TIP = "tip"


POST_TYPES = [
    PostType.ARTICLE,
    PostType.REFLECTION,
    PostType.SUCCESS_STORY,
    PostType.QUESTION,
    PostType.TIP,
]


class PostStatus:
    PUBLISHED = "published"
    PENDING = "pending"
    REMOVED = "removed"


class CommunityPost(Base):
    __tablename__ = "community_posts"

    id: Mapped[str] = mapped_column(String(32), primary_key=True, default=new_id)
    author_type: Mapped[str] = mapped_column(String(16))  # user | professional
    author_id: Mapped[str] = mapped_column(String(32), index=True)
    type: Mapped[str] = mapped_column(String(20), index=True)
    title: Mapped[str] = mapped_column(String(200), default="")
    body: Mapped[str] = mapped_column(Text, default="")
    tags: Mapped[list] = mapped_column(JSON, default=list)
    status: Mapped[str] = mapped_column(
        String(16), default=PostStatus.PUBLISHED, index=True
    )
    like_count: Mapped[int] = mapped_column(Integer, default=0)
    comment_count: Mapped[int] = mapped_column(Integer, default=0)
    share_count: Mapped[int] = mapped_column(Integer, default=0)
    created_at: Mapped[datetime] = mapped_column(DateTime, default=utcnow, index=True)
    updated_at: Mapped[datetime] = mapped_column(
        DateTime, default=utcnow, onupdate=utcnow
    )


class Comment(Base):
    __tablename__ = "comments"

    id: Mapped[str] = mapped_column(String(32), primary_key=True, default=new_id)
    post_id: Mapped[str] = mapped_column(
        ForeignKey("community_posts.id", ondelete="CASCADE"), index=True
    )
    author_type: Mapped[str] = mapped_column(String(16))
    author_id: Mapped[str] = mapped_column(String(32), index=True)
    body: Mapped[str] = mapped_column(Text)
    created_at: Mapped[datetime] = mapped_column(DateTime, default=utcnow, index=True)


class Like(Base):
    __tablename__ = "likes"
    __table_args__ = (
        UniqueConstraint("post_id", "actor_type", "actor_id", name="uq_like_actor"),
    )

    id: Mapped[str] = mapped_column(String(32), primary_key=True, default=new_id)
    post_id: Mapped[str] = mapped_column(
        ForeignKey("community_posts.id", ondelete="CASCADE"), index=True
    )
    actor_type: Mapped[str] = mapped_column(String(16))
    actor_id: Mapped[str] = mapped_column(String(32), index=True)
    created_at: Mapped[datetime] = mapped_column(DateTime, default=utcnow)


class SavedPost(Base):
    __tablename__ = "saved_posts"
    __table_args__ = (
        UniqueConstraint("post_id", "actor_type", "actor_id", name="uq_saved_actor"),
    )

    id: Mapped[str] = mapped_column(String(32), primary_key=True, default=new_id)
    post_id: Mapped[str] = mapped_column(
        ForeignKey("community_posts.id", ondelete="CASCADE"), index=True
    )
    actor_type: Mapped[str] = mapped_column(String(16))
    actor_id: Mapped[str] = mapped_column(String(32), index=True)
    created_at: Mapped[datetime] = mapped_column(DateTime, default=utcnow)
