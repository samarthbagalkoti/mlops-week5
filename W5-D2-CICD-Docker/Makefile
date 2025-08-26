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

