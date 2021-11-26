#!/usr/bin/env bash
set -e

minikube start
BASE_DIR="$(realpath "$(dirname "$0")")"

kubectl apply --filename "$BASE_DIR/mongo-namespace.yaml" --wait
kubectl apply --filename "$BASE_DIR/mongo-secret.yaml" --wait
kubectl apply --filename "$BASE_DIR/mongo.yaml" --wait
kubectl apply --filename "$BASE_DIR/mongo-express-configmap.yaml" --wait
kubectl apply --filename "$BASE_DIR/mongo-express.yaml" --wait

kubectl get all --namespace=mongo-stack | grep mongo

minikube service --namespace=mongo-stack mongo-express-service
