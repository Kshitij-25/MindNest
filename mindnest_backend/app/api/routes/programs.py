"""Wellness program endpoints (MVP 2, Phase B).

Browsing is open to any authenticated actor; authoring (create program, add
lessons, edit) is restricted to professionals.
"""
from __future__ import annotations

from fastapi import APIRouter, Depends, Query, Response, status
from sqlalchemy.ext.asyncio import AsyncSession

from app.api.deps import get_current_actor, get_current_professional
from app.database import get_db
from app.models import Professional
from app.schemas.program import (
    LessonCreate,
    LessonOut,
    ProgramCreate,
    ProgramDetailOut,
    ProgramOut,
    ProgramUpdate,
)
from app.services import program_service

router = APIRouter(prefix="/programs", tags=["Programs"])


# ---- browse (any authenticated actor) ----------------------------------------


@router.get("", response_model=list[ProgramOut])
async def list_programs(
    category: str | None = Query(None),
    limit: int = Query(50, ge=1, le=100),
    offset: int = Query(0, ge=0),
    db: AsyncSession = Depends(get_db),
    _actor: tuple[str, str] = Depends(get_current_actor),
):
    return await program_service.list_programs(
        db, category=category, limit=limit, offset=offset
    )


@router.get("/{program_id}", response_model=ProgramDetailOut)
async def get_program(
    program_id: str,
    db: AsyncSession = Depends(get_db),
    _actor: tuple[str, str] = Depends(get_current_actor),
):
    return await program_service.get_detail(db, program_id)


# ---- authoring (professionals only) ------------------------------------------


@router.post("", response_model=ProgramOut, status_code=status.HTTP_201_CREATED)
async def create_program(
    payload: ProgramCreate,
    db: AsyncSession = Depends(get_db),
    pro: Professional = Depends(get_current_professional),
):
    return program_service.program_out(await program_service.create_program(db, pro, payload))


@router.patch("/{program_id}", response_model=ProgramOut)
async def update_program(
    program_id: str,
    payload: ProgramUpdate,
    db: AsyncSession = Depends(get_db),
    pro: Professional = Depends(get_current_professional),
):
    return program_service.program_out(
        await program_service.update_program(db, pro, program_id, payload)
    )


@router.delete("/{program_id}", status_code=status.HTTP_204_NO_CONTENT)
async def delete_program(
    program_id: str,
    db: AsyncSession = Depends(get_db),
    pro: Professional = Depends(get_current_professional),
):
    await program_service.delete_program(db, pro, program_id)
    return Response(status_code=status.HTTP_204_NO_CONTENT)


@router.post(
    "/{program_id}/lessons", response_model=LessonOut, status_code=status.HTTP_201_CREATED
)
async def add_lesson(
    program_id: str,
    payload: LessonCreate,
    db: AsyncSession = Depends(get_db),
    pro: Professional = Depends(get_current_professional),
):
    return program_service.lesson_out(
        await program_service.add_lesson(db, pro, program_id, payload)
    )
