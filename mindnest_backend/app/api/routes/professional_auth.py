"""Professional authentication endpoints (MVP 2).

Mirrors ``routes/auth.py`` but for the separate professional identity space:
its tokens carry ``actor="professional"`` and its refresh sessions live in
``professional_sessions``.
"""
from __future__ import annotations

from fastapi import APIRouter, Depends, Request, status
from fastapi.security import OAuth2PasswordRequestForm
from sqlalchemy.ext.asyncio import AsyncSession

from app.api.deps import get_current_professional
from app.database import get_db
from app.models import Professional
from app.schemas.auth import RefreshRequest, SimpleMessage, Token
from app.schemas.professional import ProfessionalRegister, ProfessionalSelfOut
from app.services import professional_service

router = APIRouter(prefix="/professional/auth", tags=["Professionals"])


@router.post(
    "/register", response_model=ProfessionalSelfOut, status_code=status.HTTP_201_CREATED
)
async def register(payload: ProfessionalRegister, db: AsyncSession = Depends(get_db)):
    pro = await professional_service.register(db, payload)
    return professional_service.to_self_out(pro)


@router.post("/login", response_model=Token)
async def login(
    request: Request,
    form: OAuth2PasswordRequestForm = Depends(),
    db: AsyncSession = Depends(get_db),
):
    # OAuth2 form uses "username" — we treat it as the email.
    pro = await professional_service.authenticate(db, form.username, form.password)
    session_id = await professional_service.start_session(
        db, pro, request.headers.get("user-agent")
    )
    return professional_service.issue_tokens(pro.id, session_id)


@router.post("/refresh", response_model=Token)
async def refresh(payload: RefreshRequest, db: AsyncSession = Depends(get_db)):
    return await professional_service.refresh(db, payload.refresh_token)


@router.post("/logout", response_model=SimpleMessage)
async def logout(payload: RefreshRequest, db: AsyncSession = Depends(get_db)):
    await professional_service.logout(db, payload.refresh_token)
    return SimpleMessage(message="Logged out")


@router.get("/me", response_model=ProfessionalSelfOut)
async def me(pro: Professional = Depends(get_current_professional)):
    return professional_service.to_self_out(pro)
