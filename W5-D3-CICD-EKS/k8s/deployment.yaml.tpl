apiVersion: apps/v1
kind: Deployment
metadata:
  name: fastapi-serve
  namespace: ${K8S_NAMESPACE}
  labels:
    app: fastapi-serve
spec:
  replicas: 1
  selector:
    matchLabels:
      app: fastapi-serve
  template:
    metadata:
      labels:
        app: fastapi-serve
    spec:
      containers:
      - name: fastapi-serve
        image: ${IMAGE}
        imagePullPolicy: Always
        ports:
        - containerPort: 8000
        readinessProbe:
          httpGet:
            path: /healthz
            port: 8000
          initialDelaySeconds: 5
          periodSeconds: 5
        livenessProbe:
          httpGet:
            path: /healthz
            port: 8000
          initialDelaySeconds: 10
          periodSeconds: 10
        resources:
          requests:
            cpu: "100m"
            memory: "128Mi"
          limits:
            cpu: "500m"
            memory: "512Mi"

