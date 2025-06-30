#!/bin/bash

set -e

NAMESPACE="monitoring"
RELEASE_NAME="kube-prometheus-stack"

echo "Creating namespace $NAMESPACE..."
kubectl get ns $NAMESPACE >/dev/null 2>&1 || kubectl create ns $NAMESPACE

echo "Adding Prometheus Community Helm repo..."
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update

echo " Deploying kube-prometheus-stack..."
helm upgrade --install $RELEASE_NAME prometheus-community/kube-prometheus-stack \
  -n $NAMESPACE \
  -f values.yaml
