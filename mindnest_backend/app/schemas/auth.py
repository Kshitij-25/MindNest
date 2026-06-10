from __future__ import annotations

from datetime import datetime
from typing import Annotated

from pydantic import BaseModel, Field, StringConstraints

# A lightweight email type — avoids the heavier `email-validator` dependency
# while still rejecting obviously-malformed addresses. Good enough for the MVP.
Email = Annotated[
    str,
    StringConstraints(
        strip_whitespace=True,
        to_lower=True,
        pattern=r"^[^@\s]+@[^@\s]+\.[^@\s]+$",
    ),
]


class RegisterRequest(BaseModel):
    email: Email
    password: str = Field(min_length=6, max_length=128)
    display_name: str | None = Field(default=None, max_length=120)


class Token(BaseModel):
    access_token: str
    refresh_token: str | None = None
    token_type: str = "bearer"
    expires_in_minutes: int


class RefreshRequest(BaseModel):
    refresh_token: str


class ForgotPasswordRequest(BaseModel):
    email: str


class SimpleMessage(BaseModel):
    message: str


class UserOut(BaseModel):
    id: str
    email: str
    display_name: str | None = None
    created_at: datetime

    model_config = {"from_attributes": True}
