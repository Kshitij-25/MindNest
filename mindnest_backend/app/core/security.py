"""Authentication primitives: password hashing + JWT.

- Passwords use ``pbkdf2_sha256`` (pure-Python, no native bcrypt build).
- Tokens use HS256 JWTs (python-jose, no native crypto dependency).
Both choices keep the install light and portable across Python versions.
"""
from __future__ import annotations

from datetime import timedelta

from jose import JWTError, jwt
from passlib.context import CryptContext

from app.config import settings
from app.core.utils import utcnow

pwd_context = CryptContext(schemes=["pbkdf2_sha256"], deprecated="auto")


def hash_password(password: str) -> str:
    return pwd_context.hash(password)


def verify_password(plain: str, hashed: str) -> bool:
    try:
        return pwd_context.verify(plain, hashed)
    except ValueError:
        return False


def create_access_token(subject: str, expires_minutes: int | None = None) -> str:
    expire = utcnow() + timedelta(
        minutes=expires_minutes or settings.ACCESS_TOKEN_EXPIRE_MINUTES
    )
    payload = {"sub": subject, "exp": expire, "iat": utcnow(), "type": "access"}
    return jwt.encode(payload, settings.SECRET_KEY, algorithm=settings.ALGORITHM)


def create_refresh_token(subject: str, jti: str) -> str:
    """A long-lived refresh token bound to a server-side session (``jti``)."""
    expire = utcnow() + timedelta(minutes=settings.REFRESH_TOKEN_EXPIRE_MINUTES)
    payload = {
        "sub": subject, "exp": expire, "iat": utcnow(),
        "type": "refresh", "jti": jti,
    }
    return jwt.encode(payload, settings.SECRET_KEY, algorithm=settings.ALGORITHM)


def decode_token(token: str) -> dict | None:
    """Return the full claims dict, or ``None`` if invalid/expired."""
    try:
        return jwt.decode(token, settings.SECRET_KEY, algorithms=[settings.ALGORITHM])
    except JWTError:
        return None


def decode_access_token(token: str) -> str | None:
    """Return the subject (user id) for an access token, else ``None``.

    Tokens minted before the ``type`` claim existed are treated as access
    tokens for backwards compatibility; explicit refresh tokens are rejected.
    """
    payload = decode_token(token)
    if not payload or payload.get("type") == "refresh":
        return None
    sub = payload.get("sub")
    return sub if isinstance(sub, str) else None


# ---------------------------------------------------------------------------
# MVP 2 — multi-actor tokens (additive; the functions above are untouched so
# MVP 1 user auth is unchanged). A token carries an ``actor`` claim so a
# professional's token can never resolve as a regular user and vice-versa.
# A user token (minted by ``create_access_token``) has no ``actor`` claim and
# is therefore rejected by ``decode_actor_token(..., expected_actor=...)``.
# ---------------------------------------------------------------------------


def create_actor_token(
    subject: str, actor: str, expires_minutes: int | None = None
) -> str:
    """An access token tagged with the actor type (e.g. ``"professional"``)."""
    expire = utcnow() + timedelta(
        minutes=expires_minutes or settings.ACCESS_TOKEN_EXPIRE_MINUTES
    )
    payload = {
        "sub": subject, "exp": expire, "iat": utcnow(),
        "type": "access", "actor": actor,
    }
    return jwt.encode(payload, settings.SECRET_KEY, algorithm=settings.ALGORITHM)


def create_actor_refresh_token(subject: str, jti: str, actor: str) -> str:
    """A refresh token bound to a server-side session, tagged with the actor."""
    expire = utcnow() + timedelta(minutes=settings.REFRESH_TOKEN_EXPIRE_MINUTES)
    payload = {
        "sub": subject, "exp": expire, "iat": utcnow(),
        "type": "refresh", "jti": jti, "actor": actor,
    }
    return jwt.encode(payload, settings.SECRET_KEY, algorithm=settings.ALGORITHM)


def decode_actor_token(token: str, expected_actor: str) -> str | None:
    """Return the subject for an access token whose ``actor`` matches, else None."""
    payload = decode_token(token)
    if not payload or payload.get("type") == "refresh":
        return None
    if payload.get("actor") != expected_actor:
        return None
    sub = payload.get("sub")
    return sub if isinstance(sub, str) else None
