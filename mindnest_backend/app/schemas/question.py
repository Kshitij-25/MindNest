from __future__ import annotations

from pydantic import BaseModel


class QuestionOption(BaseModel):
    id: str
    label: str
    emoji: str | None = None


class SliderConfig(BaseModel):
    min: int = 0
    max: int = 10
    step: int = 1
    min_label: str | None = None
    max_label: str | None = None


class Progress(BaseModel):
    answered: int
    min: int
    max: int
    # rough 0..1 completion estimate for a progress bar
    fraction: float


class QuestionOut(BaseModel):
    """A single question, shaped for the client UI."""

    id: str
    text: str
    type: str  # multiple_choice | slider | free_text | emoji | journal
    dimension: str
    stage: str
    allow_skip: bool = True
    # Why the engine chose this question (great for debugging / transparency).
    reason: str | None = None

    options: list[QuestionOption] | None = None
    slider: SliderConfig | None = None
    placeholder: str | None = None
