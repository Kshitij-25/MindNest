"""Community feed: posts, comments, likes, saves, shares.

Both users and professionals participate via a generic ``(actor_type,
actor_id)`` pair. The feed is moderation-ready: only ``published`` posts are
listed, and an author can edit/remove their own posts.
"""
from __future__ import annotations

from fastapi import HTTPException, status
from sqlalchemy import select

from app.models import (
    POST_TYPES,
    Comment,
    CommunityPost,
    Like,
    PostStatus,
    SavedPost,
)


# ---- posts -------------------------------------------------------------------


async def create_post(db, actor_type: str, actor_id: str, payload) -> CommunityPost:
    if payload.type not in POST_TYPES:
        raise HTTPException(
            status.HTTP_400_BAD_REQUEST,
            f"type must be one of: {', '.join(POST_TYPES)}",
        )
    post = CommunityPost(
        author_type=actor_type,
        author_id=actor_id,
        type=payload.type,
        title=payload.title or "",
        body=payload.body or "",
        tags=payload.tags or [],
        status=PostStatus.PUBLISHED,
    )
    db.add(post)
    await db.commit()
    await db.refresh(post)
    return post


async def feed(
    db, *, type: str | None = None, limit: int = 50, offset: int = 0
) -> list[CommunityPost]:
    stmt = select(CommunityPost).where(CommunityPost.status == PostStatus.PUBLISHED)
    if type:
        stmt = stmt.where(CommunityPost.type == type)
    stmt = stmt.order_by(CommunityPost.created_at.desc()).limit(limit).offset(offset)
    res = await db.execute(stmt)
    return list(res.scalars().all())


async def get_post(db, post_id: str) -> CommunityPost:
    res = await db.execute(select(CommunityPost).where(CommunityPost.id == post_id))
    post = res.scalar_one_or_none()
    if post is None or post.status == PostStatus.REMOVED:
        raise HTTPException(status.HTTP_404_NOT_FOUND, "Post not found")
    return post


async def _owned_post(db, actor_type, actor_id, post_id) -> CommunityPost:
    post = await get_post(db, post_id)
    if post.author_type != actor_type or post.author_id != actor_id:
        raise HTTPException(status.HTTP_403_FORBIDDEN, "Not your post")
    return post


async def update_post(db, actor_type, actor_id, post_id, payload) -> CommunityPost:
    post = await _owned_post(db, actor_type, actor_id, post_id)
    data = payload.model_dump(exclude_unset=True)
    for field in ("title", "body", "tags"):
        if data.get(field) is not None:
            setattr(post, field, data[field])
    await db.commit()
    await db.refresh(post)
    return post


async def delete_post(db, actor_type, actor_id, post_id) -> None:
    post = await _owned_post(db, actor_type, actor_id, post_id)
    post.status = PostStatus.REMOVED  # soft delete keeps the feed moderation-ready
    await db.commit()


async def share(db, post_id: str) -> CommunityPost:
    post = await get_post(db, post_id)
    post.share_count += 1
    await db.commit()
    await db.refresh(post)
    return post


# ---- comments ----------------------------------------------------------------


async def add_comment(db, actor_type, actor_id, post_id, payload) -> Comment:
    post = await get_post(db, post_id)
    comment = Comment(
        post_id=post.id,
        author_type=actor_type,
        author_id=actor_id,
        body=payload.body,
    )
    db.add(comment)
    post.comment_count += 1
    await db.commit()
    await db.refresh(comment)
    return comment


async def list_comments(db, post_id: str) -> list[Comment]:
    await get_post(db, post_id)
    res = await db.execute(
        select(Comment)
        .where(Comment.post_id == post_id)
        .order_by(Comment.created_at)
    )
    return list(res.scalars().all())


# ---- likes / saves -----------------------------------------------------------


async def like(db, actor_type, actor_id, post_id) -> CommunityPost:
    post = await get_post(db, post_id)
    res = await db.execute(
        select(Like).where(
            Like.post_id == post_id,
            Like.actor_type == actor_type,
            Like.actor_id == actor_id,
        )
    )
    if res.scalar_one_or_none() is None:
        db.add(Like(post_id=post_id, actor_type=actor_type, actor_id=actor_id))
        post.like_count += 1
        await db.commit()
        await db.refresh(post)
    return post


async def unlike(db, actor_type, actor_id, post_id) -> CommunityPost:
    post = await get_post(db, post_id)
    res = await db.execute(
        select(Like).where(
            Like.post_id == post_id,
            Like.actor_type == actor_type,
            Like.actor_id == actor_id,
        )
    )
    existing = res.scalar_one_or_none()
    if existing is not None:
        await db.delete(existing)
        post.like_count = max(0, post.like_count - 1)
        await db.commit()
        await db.refresh(post)
    return post


async def save(db, actor_type, actor_id, post_id) -> None:
    await get_post(db, post_id)
    res = await db.execute(
        select(SavedPost).where(
            SavedPost.post_id == post_id,
            SavedPost.actor_type == actor_type,
            SavedPost.actor_id == actor_id,
        )
    )
    if res.scalar_one_or_none() is None:
        db.add(SavedPost(post_id=post_id, actor_type=actor_type, actor_id=actor_id))
        await db.commit()


async def unsave(db, actor_type, actor_id, post_id) -> None:
    res = await db.execute(
        select(SavedPost).where(
            SavedPost.post_id == post_id,
            SavedPost.actor_type == actor_type,
            SavedPost.actor_id == actor_id,
        )
    )
    existing = res.scalar_one_or_none()
    if existing is not None:
        await db.delete(existing)
        await db.commit()


async def list_saved(db, actor_type, actor_id) -> list[CommunityPost]:
    res = await db.execute(
        select(CommunityPost)
        .join(SavedPost, SavedPost.post_id == CommunityPost.id)
        .where(
            SavedPost.actor_type == actor_type,
            SavedPost.actor_id == actor_id,
            CommunityPost.status == PostStatus.PUBLISHED,
        )
        .order_by(SavedPost.created_at.desc())
    )
    return list(res.scalars().all())


# ---- serialization -----------------------------------------------------------


async def _actor_flags(db, actor_type, actor_id, post_ids: list[str]) -> tuple[set, set]:
    """Which of these posts the actor has liked / saved (one query each)."""
    if not post_ids:
        return set(), set()
    lres = await db.execute(
        select(Like.post_id).where(
            Like.actor_type == actor_type,
            Like.actor_id == actor_id,
            Like.post_id.in_(post_ids),
        )
    )
    sres = await db.execute(
        select(SavedPost.post_id).where(
            SavedPost.actor_type == actor_type,
            SavedPost.actor_id == actor_id,
            SavedPost.post_id.in_(post_ids),
        )
    )
    return {p for (p,) in lres.all()}, {p for (p,) in sres.all()}


def _post_out(post: CommunityPost, *, liked: bool = False, saved: bool = False) -> dict:
    return {
        "id": post.id,
        "author_type": post.author_type,
        "author_id": post.author_id,
        "type": post.type,
        "title": post.title,
        "body": post.body,
        "tags": post.tags or [],
        "status": post.status,
        "like_count": post.like_count,
        "comment_count": post.comment_count,
        "share_count": post.share_count,
        "liked_by_me": liked,
        "saved_by_me": saved,
        "created_at": post.created_at,
        "updated_at": post.updated_at,
    }


async def serialize_posts(db, actor_type, actor_id, posts: list[CommunityPost]) -> list[dict]:
    liked, saved = await _actor_flags(db, actor_type, actor_id, [p.id for p in posts])
    return [
        _post_out(p, liked=p.id in liked, saved=p.id in saved) for p in posts
    ]


async def serialize_post(db, actor_type, actor_id, post: CommunityPost) -> dict:
    liked, saved = await _actor_flags(db, actor_type, actor_id, [post.id])
    return _post_out(post, liked=post.id in liked, saved=post.id in saved)


def comment_out(c: Comment) -> dict:
    return {
        "id": c.id,
        "post_id": c.post_id,
        "author_type": c.author_type,
        "author_id": c.author_id,
        "body": c.body,
        "created_at": c.created_at,
    }
