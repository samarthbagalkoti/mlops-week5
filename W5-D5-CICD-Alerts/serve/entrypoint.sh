#!/usr/bin/env bash
set -e
# Start FastAPI with a single worker; tweak in prod
exec uvicorn app:app --host 0.0.0.0 --port 8000

