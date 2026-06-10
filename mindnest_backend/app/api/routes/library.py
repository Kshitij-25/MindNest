"""Discover & Learn library endpoints (curated wellness content)."""
from __future__ import annotations

from fastapi import APIRouter, Depends, HTTPException, status

from app.api.deps import get_current_user
from app.models import User
from app.schemas.library import ArticleOut
from app.services import library_service

router = APIRouter(prefix="/library", tags=["library"])


@router.get("", response_model=list[ArticleOut])
async def list_articles(
    category: str | None = None,
    topic: str | None = None,
    _user: User = Depends(get_current_user),
):
    return library_service.list_articles(category=category, topic=topic)


@router.get("/{article_id}", response_model=ArticleOut)
async def get_article(
    article_id: str,
    _user: User = Depends(get_current_user),
):
    article = library_service.get_article(article_id)
    if article is None:
        raise HTTPException(status.HTTP_404_NOT_FOUND, "Article not found")
    return article
