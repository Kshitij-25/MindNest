"""Wellness programs authored by professionals (lessons, exercises, prompts)."""
from __future__ import annotations

from fastapi import HTTPException, status
from sqlalchemy import func, select

from app.models import Program, ProgramLesson, ProgramStatus


async def create_program(db, pro, payload) -> Program:
    program = Program(
        author_professional_id=pro.id,
        title=payload.title,
        description=payload.description or "",
        category=payload.category or "",
        status=ProgramStatus.PUBLISHED,
    )
    db.add(program)
    await db.commit()
    await db.refresh(program)
    return program


async def _owned(db, pro, program_id: str) -> Program:
    res = await db.execute(select(Program).where(Program.id == program_id))
    program = res.scalar_one_or_none()
    if program is None or program.author_professional_id != pro.id:
        raise HTTPException(status.HTTP_404_NOT_FOUND, "Program not found")
    return program


async def update_program(db, pro, program_id: str, payload) -> Program:
    program = await _owned(db, pro, program_id)
    data = payload.model_dump(exclude_unset=True)
    for field in ("title", "description", "category", "status"):
        if data.get(field) is not None:
            setattr(program, field, data[field])
    await db.commit()
    await db.refresh(program)
    return program


async def delete_program(db, pro, program_id: str) -> None:
    program = await _owned(db, pro, program_id)
    await db.delete(program)
    await db.commit()


async def add_lesson(db, pro, program_id: str, payload) -> ProgramLesson:
    await _owned(db, pro, program_id)
    lesson = ProgramLesson(
        program_id=program_id,
        order_index=payload.order_index,
        title=payload.title,
        content=payload.content or "",
        exercise=payload.exercise or "",
        journal_prompt=payload.journal_prompt or "",
        habit_recommendation=payload.habit_recommendation or "",
    )
    db.add(lesson)
    await db.commit()
    await db.refresh(lesson)
    return lesson


async def list_programs(
    db, *, category: str | None = None, limit: int = 50, offset: int = 0
) -> list[dict]:
    stmt = select(Program).where(Program.status == ProgramStatus.PUBLISHED)
    if category:
        stmt = stmt.where(Program.category == category)
    stmt = stmt.order_by(Program.created_at.desc()).limit(limit).offset(offset)
    res = await db.execute(stmt)
    programs = list(res.scalars().all())
    counts = await _lesson_counts(db, [p.id for p in programs])
    return [program_out(p, lesson_count=counts.get(p.id, 0)) for p in programs]


async def get_detail(db, program_id: str) -> dict:
    res = await db.execute(select(Program).where(Program.id == program_id))
    program = res.scalar_one_or_none()
    if program is None or program.status != ProgramStatus.PUBLISHED:
        raise HTTPException(status.HTTP_404_NOT_FOUND, "Program not found")
    lres = await db.execute(
        select(ProgramLesson)
        .where(ProgramLesson.program_id == program_id)
        .order_by(ProgramLesson.order_index)
    )
    lessons = [lesson_out(le) for le in lres.scalars().all()]
    return {**program_out(program, lesson_count=len(lessons)), "lessons": lessons}


async def _lesson_counts(db, program_ids: list[str]) -> dict[str, int]:
    if not program_ids:
        return {}
    res = await db.execute(
        select(ProgramLesson.program_id, func.count())
        .where(ProgramLesson.program_id.in_(program_ids))
        .group_by(ProgramLesson.program_id)
    )
    return {pid: int(n) for pid, n in res.all()}


def program_out(p: Program, *, lesson_count: int = 0) -> dict:
    return {
        "id": p.id,
        "author_professional_id": p.author_professional_id,
        "title": p.title,
        "description": p.description,
        "category": p.category,
        "status": p.status,
        "lesson_count": lesson_count,
        "created_at": p.created_at,
        "updated_at": p.updated_at,
    }


def lesson_out(le: ProgramLesson) -> dict:
    return {
        "id": le.id,
        "program_id": le.program_id,
        "order_index": le.order_index,
        "title": le.title,
        "content": le.content,
        "exercise": le.exercise,
        "journal_prompt": le.journal_prompt,
        "habit_recommendation": le.habit_recommendation,
        "created_at": le.created_at,
    }
