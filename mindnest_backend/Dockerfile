# ============================================================
# MindNest API image.
#
# Base is Python 3.14-slim (matches the validated dev environment).
# Prebuilt wheels exist for the full core stack AND the optional AI
# extras (torch/transformers/sentence-transformers), so you can extend
# this image with requirements-ai.txt without a compiler.
# (Pin to python:3.13-slim instead if a dependency lags on 3.14.)
# ============================================================
FROM python:3.14-slim AS base

ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    PIP_NO_CACHE_DIR=1 \
    PIP_DISABLE_PIP_VERSION_CHECK=1

WORKDIR /app

# Install core deps first (better layer caching).
COPY requirements.txt requirements-ai.txt ./
RUN pip install -r requirements.txt

# To bake in the local AI models instead of running Ollama, uncomment:
# RUN pip install -r requirements-ai.txt

COPY app ./app
COPY scripts ./scripts

EXPOSE 8000

# 1 worker keeps the SQLite MVP simple; scale out only with Postgres.
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]
