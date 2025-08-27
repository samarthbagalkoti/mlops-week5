#!/usr/bin/env bash
set -euo pipefail

if [[ $# -lt 4 ]]; then
  echo "Usage: $0 <image> <namespace> <cluster> <region>"
  exit 1
fi

IMAGE="$1"
NS="$2"
CLUSTER="$3"
REGION="$4"

aws eks update-kubeconfig --name "$CLUSTER" --region "$REGION"

# Render from templates
mkdir -p out
IMAGE="$IMAGE" K8S_NAMESPACE="$NS" envsubst < k8s/namespace.yaml > out/namespace.yaml
IMAGE="$IMAGE" K8S_NAMESPACE="$NS" envsubst < k8s/deployment.yaml.tpl > out/deployment.yaml
IMAGE="$IMAGE" K8S_NAMESPACE="$NS" envsubst < k8s/service.yaml > out/service.yaml
IMAGE="$IMAGE" K8S_NAMESPACE="$NS" envsubst < k8s/hpa.yaml > out/hpa.yaml

# Apply
kubectl apply -f out/namespace.yaml || true
kubectl apply -f out/deployment.yaml
kubectl apply -f out/service.yaml
kubectl apply -f out/hpa.yaml

# Wait for rollout
kubectl -n "$NS" rollout status deploy/fastapi-serve --timeout=180s
kubectl -n "$NS" get svc fastapi-serve-svc -o wide

