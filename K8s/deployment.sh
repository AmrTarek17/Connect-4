cat << EOF | kubectl apply -f-
apiVersion: apps/v1
kind: Deployment
metadata:
  name: game-deployment
spec:
  replicas: 3
  selector:
    matchLabels:
      app: game-pod
  template:
    metadata:
      labels:
        app: game-pod
    spec:
      containers:
      - name: game-container
        image: ${IMG_NAME}:${NEW_TAG}
        ports:
        - containerPort: 80
EOF