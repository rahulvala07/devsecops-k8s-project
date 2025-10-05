# Quick Start Guide

## Prerequisites

- Docker Desktop with Kubernetes enabled
- kubectl, helm installed
- 5 minutes

## Setup (3 commands)
```bash
# 1. Bootstrap
./scripts/bootstrap-local.sh

# 2. Build & push image
cd app
docker build -t YOUR_USER/devsecops-app:v1.0.0 .
docker push YOUR_USER/devsecops-app:v1.0.0

# 3. Deploy
kubectl apply -f ../k8s/base/ -n development