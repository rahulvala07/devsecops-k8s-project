#!/bin/bash

echo "🔒 Running Security Tests"

# Test 1: Pod health
echo "Test 1: Pod health..."
kubectl get pods -n development | grep -q "Running" && echo "✓ PASS" || echo "✗ FAIL"

# Test 2: Policies
echo "Test 2: Kyverno policies..."
COUNT=$(kubectl get clusterpolicy 2>/dev/null | grep -c "disallow\|require" || echo "0")
[ "$COUNT" -ge 2 ] && echo "✓ PASS ($COUNT policies)" || echo "✗ FAIL"

# Test 3: Policy enforcement
echo "Test 3: Policy enforcement..."
kubectl run test-latest --image=nginx:latest -n development 2>&1 | grep -q "denied\|blocked" && \
  echo "✓ PASS (blocked latest tag)" || echo "✗ FAIL"
kubectl delete pod test-latest -n development 2>/dev/null || true

echo ""
echo "✅ Security tests complete!"