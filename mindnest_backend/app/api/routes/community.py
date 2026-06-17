"""Community feed endpoints (MVP 2, Phase B).

Open to both users and professionals (``get_current_actor``). Professionals'
posts are how expert content (articles, guides, tips) reaches the feed.
"""
from __future__ import annotations

from fastapi import APIRouter, Depends, Query, Response, status
from sqlalchemy.ext.asyncio import AsyncSession

from app.api.deps import get_current_actor
from app.database import get_db
from app.schemas.community import (
    CommentCreate,
    CommentOut,
    PostCreate,
    PostOut,
    PostUpdate,
)
from app.services import community_service

router = APIRouter(prefix="/community", tags=["Community"])


@router.get("/posts", response_model=list[PostOut])
async def list_posts(
    type: str | None = Query(None),
    limit: int = Query(50, ge=1, le=100),
    offset: int = Query(0, ge=0),
    db: AsyncSession = Depends(get_db),
    actor: tuple[str, str] = Depends(get_current_actor),
):
    posts = await community_service.feed(db, type=type, limit=limit, offset=offset)
    return await community_service.serialize_posts(db, actor[0], actor[1], posts)


@router.post("/posts", response_model=PostOut, status_code=status.HTTP_201_CREATED)
async def create_post(
    payload: PostCreate,
    db: AsyncSession = Depends(get_db),
    actor: tuple[str, str] = Depends(get_current_actor),
):
    post = await community_service.create_post(db, actor[0], actor[1], payload)
    return await community_service.serialize_post(db, actor[0], actor[1], post)


@router.get("/posts/saved", response_model=list[PostOut])
async def saved_posts(
    db: AsyncSession = Depends(get_db),
    actor: tuple[str, str] = Depends(get_current_actor),
):
    posts = await community_service.list_saved(db, actor[0], actor[1])
    return await community_service.serialize_posts(db, actor[0], actor[1], posts)


@router.get("/posts/{post_id}", response_model=PostOut)
async def get_post(
    post_id: str,
    db: AsyncSession = Depends(get_db),
    actor: tuple[str, str] = Depends(get_current_actor),
):
    post = await community_service.get_post(db, post_id)
    return await community_service.serialize_post(db, actor[0], actor[1], post)


@router.patch("/posts/{post_id}", response_model=PostOut)
async def update_post(
    post_id: str,
    payload: PostUpdate,
    db: AsyncSession = Depends(get_db),
    actor: tuple[str, str] = Depends(get_current_actor),
):
    post = await community_service.update_post(db, actor[0], actor[1], post_id, payload)
    return await community_service.serialize_post(db, actor[0], actor[1], post)


@router.delete("/posts/{post_id}", status_code=status.HTTP_204_NO_CONTENT)
async def delete_post(
    post_id: str,
    db: AsyncSession = Depends(get_db),
    actor: tuple[str, str] = Depends(get_current_actor),
):
    await community_service.delete_post(db, actor[0], actor[1], post_id)
    return Response(status_code=status.HTTP_204_NO_CONTENT)


# ---- interactions ------------------------------------------------------------


@router.post("/posts/{post_id}/like", response_model=PostOut)
async def like_post(
    post_id: str,
    db: AsyncSession = Depends(get_db),
    actor: tuple[str, str] = Depends(get_current_actor),
):
    await community_service.like(db, actor[0], actor[1], post_id)
    return await community_service.serialize_post(
        db, actor[0], actor[1], await community_service.get_post(db, post_id)
    )


@router.delete("/posts/{post_id}/like", response_model=PostOut)
async def unlike_post(
    post_id: str,
    db: AsyncSession = Depends(get_db),
    actor: tuple[str, str] = Depends(get_current_actor),
):
    await community_service.unlike(db, actor[0], actor[1], post_id)
    return await community_service.serialize_post(
        db, actor[0], actor[1], await community_service.get_post(db, post_id)
    )


@router.post("/posts/{post_id}/save", status_code=status.HTTP_204_NO_CONTENT)
async def save_post(
    post_id: str,
    db: AsyncSession = Depends(get_db),
    actor: tuple[str, str] = Depends(get_current_actor),
):
    await community_service.save(db, actor[0], actor[1], post_id)
    return Response(status_code=status.HTTP_204_NO_CONTENT)


@router.delete("/posts/{post_id}/save", status_code=status.HTTP_204_NO_CONTENT)
async def unsave_post(
    post_id: str,
    db: AsyncSession = Depends(get_db),
    actor: tuple[str, str] = Depends(get_current_actor),
):
    await community_service.unsave(db, actor[0], actor[1], post_id)
    return Response(status_code=status.HTTP_204_NO_CONTENT)


@router.post("/posts/{post_id}/share", response_model=PostOut)
async def share_post(
    post_id: str,
    db: AsyncSession = Depends(get_db),
    actor: tuple[str, str] = Depends(get_current_actor),
):
    post = await community_service.share(db, post_id)
    return await community_service.serialize_post(db, actor[0], actor[1], post)


@router.get("/posts/{post_id}/comments", response_model=list[CommentOut])
async def list_comments(
    post_id: str,
    db: AsyncSession = Depends(get_db),
    _actor: tuple[str, str] = Depends(get_current_actor),
):
    return [community_service.comment_out(c) for c in await community_service.list_comments(db, post_id)]


@router.post(
    "/posts/{post_id}/comments",
    response_model=CommentOut,
    status_code=status.HTTP_201_CREATED,
)
async def add_comment(
    post_id: str,
    payload: CommentCreate,
    db: AsyncSession = Depends(get_db),
    actor: tuple[str, str] = Depends(get_current_actor),
):
    comment = await community_service.add_comment(db, actor[0], actor[1], post_id, payload)
    return community_service.comment_out(comment)
