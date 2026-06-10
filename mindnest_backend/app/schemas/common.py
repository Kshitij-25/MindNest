"""Shared schema primitives for all NEW UI-facing endpoints.

The Flutter client (``mindnest_app``) deserializes ``response.data`` straight
into freezed models whose JSON keys are **camelCase**, and reads a top-level
``"message"`` from error bodies. So every new schema:

* subclasses :class:`CamelModel` (snake_case in Python, camelCase on the wire),
* accepts either casing on input (``populate_by_name=True``),
* never wraps success payloads in an envelope.

Legacy schemas (``schemas/auth.py``, ``mood.py``, ``assessment.py``,
``question.py``) deliberately stay plain ``BaseModel`` so the existing
``/assessment`` and ``/profile`` contracts remain snake_case.
"""
from __future__ import annotations

from typing import Generic, TypeVar

from pydantic import BaseModel, ConfigDict
from pydantic.alias_generators import to_camel

T = TypeVar("T")


class CamelModel(BaseModel):
    """Base for UI-facing schemas: camelCase out, both casings in."""

    model_config = ConfigDict(
        alias_generator=to_camel,
        populate_by_name=True,
        from_attributes=True,
    )


class ErrorBody(CamelModel):
    """The error envelope the Flutter ``error_mapper`` consumes.

    ``message`` is what the client surfaces; ``code`` is a stable machine
    string; ``detail`` is preserved for the legacy reference client / FastAPI.
    """

    message: str
    code: str = "error"
    detail: object | None = None


class Page(CamelModel, Generic[T]):
    """Offset pagination wrapper (used by lists that need a total count)."""

    items: list[T]
    total: int
    limit: int
    offset: int


class CursorPage(CamelModel, Generic[T]):
    """Keyset pagination wrapper for unbounded feeds (stable under inserts)."""

    items: list[T]
    next_cursor: str | None = None
