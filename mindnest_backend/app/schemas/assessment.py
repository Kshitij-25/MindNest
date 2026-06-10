from __future__ import annotations

from datetime import datetime
from typing import Any

from pydantic import BaseModel, Field, model_validator

from app.schemas.common import CamelModel
from app.schemas.question import Progress, QuestionOut


class StartAssessmentRequest(BaseModel):
    # Optional client context (device, locale, app_version, ...).
    meta: dict[str, Any] = Field(default_factory=dict)


class AnswerRequest(BaseModel):
    question_id: str
    option_id: str | None = None
    value: float | None = None
    text: str | None = None
    skipped: bool = False

    @model_validator(mode="after")
    def _at_least_one(self) -> "AnswerRequest":
        if self.skipped:
            return self
        if self.option_id is None and self.value is None and not (self.text or "").strip():
            raise ValueError(
                "Provide one of option_id / value / text, or set skipped=true."
            )
        return self

    def to_raw(self) -> dict[str, Any]:
        if self.skipped:
            return {"skipped": True}
        if self.option_id is not None:
            return {"option_id": self.option_id}
        if self.value is not None:
            return {"value": self.value}
        return {"text": (self.text or "").strip()}


class NextQuestionOut(BaseModel):
    assessment_id: str
    done: bool
    question: QuestionOut | None = None
    progress: Progress
    # Lightweight live snapshot of the strongest signals so far.
    interim_top: list[dict[str, Any]] = Field(default_factory=list)


class AnswerAccepted(NextQuestionOut):
    """Returned by POST /assessment/answer — same as next-question plus a flag."""

    accepted: bool = True


class AssessmentSummary(BaseModel):
    id: str
    status: str
    stage: str
    question_count: int
    started_at: datetime
    completed_at: datetime | None = None

    model_config = {"from_attributes": True}


# ---- templates + history (NEW, camelCase) ------------------------------------


class AssessmentTemplateOut(CamelModel):
    id: str
    name: str
    description: str
    min_questions: int
    max_questions: int
    focus: list[str] = Field(default_factory=list)


class AssessmentHistoryItem(CamelModel):
    assessment_id: str
    template: str
    source: str
    created_at: datetime
    overall_mood: str
    valence: float
    confidence: float
    top_emotions: list[Any] = Field(default_factory=list)
