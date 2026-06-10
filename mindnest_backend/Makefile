# MindNest — common tasks. Usage: `make <target>`
.PHONY: help install install-ai run seed test fmt docker docker-ai clean

VENV ?= .venv
PY := $(VENV)/bin/python
PIP := $(VENV)/bin/pip

help:           ## Show this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
	  awk 'BEGIN{FS=":.*?## "}{printf "  \033[36m%-12s\033[0m %s\n", $$1, $$2}'

$(VENV):
	python3 -m venv $(VENV)

install: $(VENV)  ## Install core dependencies (lightweight)
	$(PIP) install -U pip
	$(PIP) install -r requirements.txt

install-ai:       ## Install optional AI model dependencies
	$(PIP) install -r requirements-ai.txt

run:              ## Run the API with autoreload
	$(VENV)/bin/uvicorn app.main:app --reload

seed:             ## Seed a demo user with 2 weeks of history
	$(PY) -m scripts.seed_demo

test:             ## Run the test suite
	$(PY) -m pytest

docker:           ## Build & run the API container (rule-based only)
	docker compose up --build

docker-ai:        ## Build & run API + local Ollama
	docker compose --profile ai up --build

clean:            ## Remove caches and local DB files
	rm -rf .pytest_cache **/__pycache__ *.db test_*.db
