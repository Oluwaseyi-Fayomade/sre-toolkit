#!/bin/bash

echo "================================================"
echo "       SRE TOOLKIT — Restart Detector"
echo "================================================"

CURRENT_DATE=$(date "+%Y-%m-%d %H:%M:%S")
NAMESPACE="default"
THRESHOLD=3
PODS=$(kubectl get pods)
RESTART_COUNTS=$(kubectl get pods --no-headers | awk '{print $4}')
MAX_RESTARTS=$(echo "$RESTART_COUNTS" | sort -rn | head -1)

echo "Checked   : $CURRENT_DATE"
echo "Namespace : $NAMESPACE"
echo "Threshold : $THRESHOLD restarts"
echo "------------------------------------------------"
echo "POD RESTART COUNTS:"
echo "$PODS"
echo "------------------------------------------------"
if [ -z "$MAX_RESTARTS" ]; then
    echo "STATUS    : NO PODS FOUND in namespace '$NAMESPACE'"
elif [ "$MAX_RESTARTS" -gt "$THRESHOLD" ]; then
    echo "STATUS    : ALERT — pod(s) exceeding $THRESHOLD restarts (max: $MAX_RESTARTS)"
else
    echo "STATUS    : No pods exceeding restart threshold"
fi
echo "================================================"