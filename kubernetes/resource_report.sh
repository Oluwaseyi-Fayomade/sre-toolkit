#!/bin/bash

echo "================================================"
echo "       SRE TOOLKIT — Resource Report"
echo "================================================"

CURRENT_DATE=$(date "+%Y-%m-%d %H:%M:%S")
NAMESPACE="default"
RESOURCE_USAGE=$(kubectl top pods)

echo "Checked   : $CURRENT_DATE"
echo "Namespace : $NAMESPACE"
echo "------------------------------------------------"
echo "POD RESOURCE USAGE:"
echo "$RESOURCE_USAGE"
echo "------------------------------------------------"
echo "STATUS    : Resource report generated"
echo "================================================"