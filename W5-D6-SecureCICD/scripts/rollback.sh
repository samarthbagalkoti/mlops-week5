#!/usr/bin/env bash
set -euo pipefail

if [[ $# -lt 5 ]]; then
  echo "Usage: $0 <registry_repo> <tag> <namespace> <cluster> <region>"
  echo "Example: $0 dockeruser/mlops-w5-serve 3bd2e1a mlops-w5 eks-demo ap-south-1"
  exit 1
fi

REPO="$1"
TAG="$2"
NS="$3"
CLUSTER="$4"
REGION="$5"

aws eks update-kubeconfig --name "$CLUSTER" --region "$REGION"

# Swap deployment image to a known-good tag
kubectl -n "$NS" set image deploy/fastapi-serve fastapi-serve="${REPO}:${TAG}"
kubectl -n "$NS" rollout status deploy/fastapi-serve --timeout=180s
kubectl -n "$NS" describe deploy/fastapi-serve | sed -n '1,120p'

