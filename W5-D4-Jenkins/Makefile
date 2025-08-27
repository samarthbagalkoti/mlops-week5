REGISTRY ?= samarthbagalkoti
IMAGE_NAME ?= mlops-w5-serve
TAG ?= v1
IMAGE := $(REGISTRY)/$(IMAGE_NAME):$(TAG)

K8S_NAMESPACE ?= mlops-w5
KUBECTL ?= kubectl

serve-build:
	docker build -f serve/Dockerfile.serve -t $(IMAGE) serve

serve-run:
	docker run --rm -p 8000:8000 $(IMAGE)

k8s-render:
	IMAGE=$(IMAGE) K8S_NAMESPACE=$(K8S_NAMESPACE) envsubst < k8s/namespace.yaml | tee /tmp/ns.yaml >/dev/null
	IMAGE=$(IMAGE) K8S_NAMESPACE=$(K8S_NAMESPACE) envsubst < k8s/deployment.yaml.tpl | tee /tmp/deploy.yaml >/dev/null
	IMAGE=$(IMAGE) K8S_NAMESPACE=$(K8S_NAMESPACE) envsubst < k8s/service.yaml | tee /tmp/svc.yaml >/dev/null
	IMAGE=$(IMAGE) K8S_NAMESPACE=$(K8S_NAMESPACE) envsubst < k8s/hpa.yaml | tee /tmp/hpa.yaml >/dev/null

k8s-apply: k8s-render
	$(KUBECTL) apply -f /tmp/ns.yaml || true
	$(KUBECTL) apply -f /tmp/deploy.yaml
	$(KUBECTL) apply -f /tmp/svc.yaml
	$(KUBECTL) apply -f /tmp/hpa.yaml

k8s-status:
	$(KUBECTL) -n $(K8S_NAMESPACE) get all

setup:
	pip install -r requirements.txt

run:
	python train.py

test:
	pytest -v

docker-build:
	docker build -t samarthbagalkoti/mlops-w5-d2:v1 .

docker-run:
	docker run --rm samarthbagalkoti/mlops-w5-d2:v1

docker-clean:
	docker rmi samarthbagalkoti/mlops-w5-d2:v1 || true


