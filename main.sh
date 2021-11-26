#!/usr/bin/env bash
set -e

minikube start
BASE_DIR="$(realpath "$(dirname "$0")")"

kubectl apply --filename "$BASE_DIR/mongo-namespace.yaml" --wait
kubectl apply --filename "$BASE_DIR/mongo-secret.yaml" --namespace=mongo-stack --wait
kubectl apply --filename "$BASE_DIR/mongo.yaml" --namespace=mongo-stack --wait
kubectl apply --filename "$BASE_DIR/mongo-express-configmap.yaml" --namespace=mongo-stack --wait
kubectl apply --filename "$BASE_DIR/mongo-express.yaml" --namespace=mongo-stack --wait

kubectl get all --namespace=mongo-stack | grep mongo

minikube service mongo-express-service
