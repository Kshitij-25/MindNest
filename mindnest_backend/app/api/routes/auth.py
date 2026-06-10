"""Authentication endpoints."""
from __future__ import annotations

from fastapi import APIRouter, Depends, HTTPException, Request, status
from fastapi.security import OAuth2PasswordRequestForm
from sqlalchemy import delete, select
from sqlalchemy.ext.asyncio import AsyncSession

from app.api.deps import get_current_user
from app.config import settings
from app.core.security import (
    create_access_token,
    create_refresh_token,
    decode_token,
    hash_password,
    verify_password,
)
from app.database import get_db
from app.models import Session, User
from app.schemas.auth import (
    ForgotPasswordRequest,
    RefreshRequest,
    RegisterRequest,
    SimpleMessage,
    Token,
    UserOut,
)

router = APIRouter(prefix="/auth", tags=["auth"])


def _issue_tokens(user_id: str, session_id: str) -> Token:
    return Token(
        access_token=create_access_token(subject=user_id),
        refresh_token=create_refresh_token(subject=user_id, jti=session_id),
        expires_in_minutes=settings.ACCESS_TOKEN_EXPIRE_MINUTES,
    )


@router.post("/register", response_model=UserOut, status_code=status.HTTP_201_CREATED)
async def register(payload: RegisterRequest, db: AsyncSession = Depends(get_db)):
    existing = await db.execute(select(User).where(User.email == payload.email))
    if existing.scalar_one_or_none() is not None:
        raise HTTPException(status.HTTP_409_CONFLICT, "Email already registered")
    user = User(
        email=payload.email,
        hashed_password=hash_password(payload.password),
        display_name=payload.display_name,
    )
    db.add(user)
    await db.commit()
    await db.refresh(user)
    return user


@router.post("/login", response_model=Token)
async def login(
    request: Request,
    form: OAuth2PasswordRequestForm = Depends(),
    db: AsyncSession = Depends(get_db),
):
    # OAuth2 form uses "username" — we treat it as the email.
    res = await db.execute(select(User).where(User.email == form.username.lower()))
    user = res.scalar_one_or_none()
    if user is None or not verify_password(form.password, user.hashed_password):
        raise HTTPException(
            status.HTTP_401_UNAUTHORIZED,
            "Incorrect email or password",
            headers={"WWW-Authenticate": "Bearer"},
        )
    session = Session(
        user_id=user.id,
        device=request.headers.get("user-agent", "")[:255] or None,
    )
    db.add(session)
    await db.commit()
    await db.refresh(session)
    return _issue_tokens(user.id, session.id)


@router.post("/refresh", response_model=Token)
async def refresh(payload: RefreshRequest, db: AsyncSession = Depends(get_db)):
    """Exchange a valid refresh token for a fresh access + refresh pair."""
    claims = decode_token(payload.refresh_token)
    if not claims or claims.get("type") != "refresh":
        raise HTTPException(status.HTTP_401_UNAUTHORIZED, "Invalid refresh token")
    jti = claims.get("jti")
    sub = claims.get("sub")
    res = await db.execute(select(Session).where(Session.id == jti))
    session = res.scalar_one_or_none()
    if session is None or session.user_id != sub:
        raise HTTPException(status.HTTP_401_UNAUTHORIZED, "Session no longer valid")
    return _issue_tokens(sub, session.id)


@router.post("/logout", response_model=SimpleMessage)
async def logout(payload: RefreshRequest, db: AsyncSession = Depends(get_db)):
    """Revoke the session bound to a refresh token (idempotent)."""
    claims = decode_token(payload.refresh_token)
    if claims and claims.get("jti"):
        await db.execute(delete(Session).where(Session.id == claims["jti"]))
        await db.commit()
    return SimpleMessage(message="Logged out")


@router.post("/forgot-password", response_model=SimpleMessage)
async def forgot_password(payload: ForgotPasswordRequest, db: AsyncSession = Depends(get_db)):
    """Begin a password reset.

    No email provider is configured yet, so this always succeeds without
    revealing whether the address exists (avoids account enumeration). A real
    provider is wired in P1.
    """
    return SimpleMessage(
        message="If that email is registered, a reset link is on its way."
    )


@router.get("/me", response_model=UserOut)
async def me(current_user: User = Depends(get_current_user)):
    return current_user
