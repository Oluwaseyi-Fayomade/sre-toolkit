#!/bin/bash

echo "================================================"
echo "       SRE TOOLKIT — Master Check Runner"
echo "================================================"

mkdir -p ~/sre-toolkit/linux/reports

TIMESTAMP=$(date "+%Y-%m-%d_%H-%M-%S")
REPORT_FILE=~/sre-toolkit/linux/reports/report_${TIMESTAMP}.log

STARTED=$(date "+%Y-%m-%d %H:%M:%S")
echo "Started    : $STARTED"

echo "------------------------------------------------"
echo "Running health_check.sh..." 
bash ~/sre-toolkit/linux/health_check.sh >> "$REPORT_FILE"

echo "Running log_parser.sh..."
bash ~/sre-toolkit/linux/log_parser.sh >> "$REPORT_FILE"

echo "Running disk_alert.sh..."
bash ~/sre-toolkit/linux/disk_alert.sh >> "$REPORT_FILE"
echo "------------------------------------------------"
echo "Report saved to: $REPORT_FILE"
echo "================================================"