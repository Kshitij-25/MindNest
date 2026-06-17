"""Shared FastAPI dependencies (auth)."""
from __future__ import annotations

from fastapi import Depends, Header, HTTPException, status
from fastapi.security import OAuth2PasswordBearer
from sqlalchemy import select
from sqlalchemy.ext.asyncio import AsyncSession

from app.config import settings
from app.core.security import decode_access_token, decode_actor_token
from app.database import get_db
from app.models import Professional, User

oauth2_scheme = OAuth2PasswordBearer(tokenUrl=f"{settings.API_PREFIX}/auth/login")
# Separate token URL for the professional identity space (MVP 2).
pro_oauth2_scheme = OAuth2PasswordBearer(
    tokenUrl=f"{settings.API_PREFIX}/professional/auth/login",
    auto_error=False,
)

_CREDENTIALS_EXC = HTTPException(
    status_code=status.HTTP_401_UNAUTHORIZED,
    detail="Could not validate credentials",
    headers={"WWW-Authenticate": "Bearer"},
)

_ADMIN_EXC = HTTPException(
    status_code=status.HTTP_403_FORBIDDEN,
    detail="Admin privileges required",
)

PROFESSIONAL_ACTOR = "professional"


async def get_current_user(
    token: str = Depends(oauth2_scheme),
    db: AsyncSession = Depends(get_db),
) -> User:
    sub = decode_access_token(token)
    if not sub:
        raise _CREDENTIALS_EXC
    res = await db.execute(select(User).where(User.id == sub))
    user = res.scalar_one_or_none()
    if user is None or not user.is_active:
        raise _CREDENTIALS_EXC
    return user


async def get_current_professional(
    token: str | None = Depends(pro_oauth2_scheme),
    db: AsyncSession = Depends(get_db),
) -> Professional:
    """Resolve a professional from an ``actor="professional"`` access token.

    A regular user token (no ``actor`` claim) is rejected here, and a
    professional token never resolves as a user (its id isn't in ``users``),
    so the two identity spaces stay fully isolated.
    """
    sub = decode_actor_token(token or "", PROFESSIONAL_ACTOR)
    if not sub:
        raise _CREDENTIALS_EXC
    res = await db.execute(select(Professional).where(Professional.id == sub))
    pro = res.scalar_one_or_none()
    if pro is None or not pro.is_active:
        raise _CREDENTIALS_EXC
    return pro


async def get_current_actor(
    token: str = Depends(oauth2_scheme),
    db: AsyncSession = Depends(get_db),
) -> tuple[str, str]:
    """Resolve EITHER a user or a professional from a bearer token.

    Returns ``(actor_type, actor_id)`` where ``actor_type`` is ``"user"`` or
    ``"professional"``. Used by shared spaces (community, program browsing)
    that both identity types participate in.
    """
    pro_sub = decode_actor_token(token, PROFESSIONAL_ACTOR)
    if pro_sub:
        res = await db.execute(select(Professional).where(Professional.id == pro_sub))
        pro = res.scalar_one_or_none()
        if pro is None or not pro.is_active:
            raise _CREDENTIALS_EXC
        return (PROFESSIONAL_ACTOR, pro.id)

    user_sub = decode_access_token(token)
    if user_sub:
        res = await db.execute(select(User).where(User.id == user_sub))
        user = res.scalar_one_or_none()
        if user is not None and user.is_active:
            return ("user", user.id)
    raise _CREDENTIALS_EXC


async def require_admin(x_admin_token: str | None = Header(default=None)) -> bool:
    """Gate manual-review endpoints behind a shared admin token.

    MVP 1 has no admin actor; rather than invent an RBAC system, verification
    review is protected by ``ADMIN_API_TOKEN`` (unset/empty ⇒ always 403).
    """
    expected = (settings.ADMIN_API_TOKEN or "").strip()
    if not expected or x_admin_token != expected:
        raise _ADMIN_EXC
    return True
