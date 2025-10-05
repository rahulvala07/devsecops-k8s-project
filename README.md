# DevSecOps Kubernetes Project

[![Build](https://img.shields.io/badge/build-passing-brightgreen)]()
[![Security](https://img.shields.io/badge/security-hardened-blue)]()
[![K8s](https://img.shields.io/badge/kubernetes-1.28-326CE5)]()

Production-ready DevSecOps pipeline with Kubernetes, featuring multi-layered security scanning, policy enforcement, runtime monitoring, and comprehensive observability.

## 🚀 Quick Start 
```bash
# 1. Clone repository
git clone https://github.com/rahulvala07/project.git
cd devsecops-k8s-project

# 2. Run bootstrap script
./scripts/bootstrap-local.sh

# 3. Access services
kubectl port-forward -n development svc/devsecops-app 8080:80
# Visit: http://localhost:8080