SHELL:=/usr/bin/env bash
APP_ENV ?= test

.PHONY: format mypy flake lint sunit unit package revision test stest prestart

format:
	poetry run isort app tests
	poetry run black app tests

mypy:
	poetry run mypy app tests

flake:
	poetry run flake8 app tests

lint: format mypy flake
	# poetry run docr8 -q docs

sunit:
	poetry run pytest -s tests

unit:
	poetry run pytest tests

package:
	poetry check
	poetry run pip check
	poetry run safety check -i 51499 --short-report

test: lint package unit

stest: lint package sunit

revision:
	@echo "not executed: poetry run alembic revision --autogenerate -m your_message"

prestart:
	APP_ENV=$(APP_ENV) poetry run python prestart.py

.PHONY: clean clean-build clean-pyc clean-test
clean: clean-build clean-pyc clean-test ## remove all build, test, coverage and Python artifacts

clean-build: ## remove build artifacts
	rm -fr build/
	rm -fr docs/_build
	rm -fr dist/
	rm -fr .eggs/
	find . -name '*.egg-info' -exec rm -fr {} +
	find . -name '*.egg' -exec rm -f {} +

clean-pyc: ## remove Python file artifacts
	find . -name '*.pyc' -exec rm -f {} +
	find . -name '*.pyo' -exec rm -f {} +
	find . -name '*~' -exec rm -f {} +
	find . -name '__pycache__' -exec rm -fr {} +

clean-test: ## remove test and coverage artifacts
	rm -fr .tox/
	rm -f .coverage
	rm -fr htmlcov/
	rm -fr .pytest_cache
	rm -fr .mypy_cache
