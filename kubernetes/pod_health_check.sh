#!/bin/bash

echo "================================================"
echo "       SRE TOOLKIT — Pod Health Check"
echo "================================================"

CURRENT_DATE=$(date "+%Y-%m-%d %H:%M:%S")
NAMESPACE="default"
PODS=$(kubectl get pods) 
NOT_RUNNING=$(kubectl get pods | grep -v "Running" | grep -v "NAME" | wc -l | tr -d ' ')
TOTAL_PODS=$(kubectl get pods --no-headers | wc -l | tr -d ' ')

echo "Checked   : $CURRENT_DATE"
echo "Namespace : $NAMESPACE"
echo "------------------------------------------------"
echo "POD STATUS:"
echo "$PODS"
echo "------------------------------------------------"

if [ $TOTAL_PODS -eq 0 ]; then
    echo "STATUS    : ⚠ NO PODS FOUND in namespace '$NAMESPACE'"
elif [ $NOT_RUNNING -gt 0 ]; then
    echo "STATUS    : ⚠ ALERT — $NOT_RUNNING pod(s) not running"
else
    echo "STATUS    : ✓ All pods healthy"
fi
echo "================================================"
