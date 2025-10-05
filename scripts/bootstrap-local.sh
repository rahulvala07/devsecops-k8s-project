#!/bin/bash
set -e

echo "🚀 DevSecOps Quick Setup"
echo "========================"

# Check prerequisites
echo "✓ Checking prerequisites..."
command -v kubectl >/dev/null 2>&1 || { echo "kubectl required"; exit 1; }
command -v helm >/dev/null 2>&1 || { echo "helm required"; exit 1; }
command -v docker >/dev/null 2>&1 || { echo "docker required"; exit 1; }

# Create namespaces
echo "✓ Creating namespaces..."
kubectl create namespace development --dry-run=client -o yaml | kubectl apply -f -
kubectl create namespace monitoring --dry-run=client -o yaml | kubectl apply -f -

# Install Kyverno
echo "✓ Installing Kyverno..."
helm repo add kyverno https://kyverno.github.io/kyverno/ 2>/dev/null || true
helm repo update
helm upgrade --install kyverno kyverno/kyverno -n kyverno --create-namespace --wait

# Install Prometheus
echo "✓ Installing Prometheus & Grafana..."
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts 2>/dev/null || true
helm upgrade --install prometheus prometheus-community/kube-prometheus-stack \
  -n monitoring --set grafana.adminPassword=admin123 --wait

echo ""
echo "✅ Setup Complete!"
echo ""
echo "Next steps:"
echo "  1. Build app: cd app && docker build -t YOUR_USER/devsecops-app:v1.0.0 ."
echo "  2. Push: docker push YOUR_USER/devsecops-app:v1.0.0"
echo "  3. Deploy: kubectl apply -f k8s/base/ -n development"
echo "  4. Access: kubectl port-forward -n development svc/devsecops-app 8080:80"