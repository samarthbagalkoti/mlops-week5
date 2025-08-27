# W5-D3 EKS CD Runbook

## What this does
- Builds a FastAPI serve image
- Pushes to registry (Docker Hub or ECR)
- Applies K8s manifests to an EKS namespace
- Provides LB Service + HPA

## One-time AWS setup
- Create IAM role for GitHub OIDC with EKS permissions
- Grant cluster access to that role via aws-auth ConfigMap

## GitHub configuration
- Vars: AWS_ACCOUNT_ID, AWS_REGION, EKS_CLUSTER_NAME, K8S_NAMESPACE, CONTAINER_REGISTRY, REGISTRY_REPO
- Secrets: AWS_ROLE_TO_ASSUME
- (If Docker Hub): DOCKER_USERNAME, DOCKER_PASSWORD

## Useful commands
- Check rollout: `kubectl -n $NS rollout status deploy/fastapi-serve`
- Check svc: `kubectl -n $NS get svc fastapi-serve-svc -o wide`
- Logs: `kubectl -n $NS logs deploy/fastapi-serve -f`
- Update image: push new commit → pipeline tags and rolls out automatically
- Rollback: `kubectl -n $NS rollout undo deploy/fastapi-serve`

