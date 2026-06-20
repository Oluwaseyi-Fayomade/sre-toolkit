#!/bin/bash

echo "================================================"
echo "       SRE TOOLKIT — Disk Alert Check"
echo "================================================"

CURRENT_DATE=$(date "+%Y-%m-%d %H:%M:%S")
DISK_USAGE=$(df -h / | awk 'NR==2 {print $5}')
DISK_NUM=$(echo $DISK_USAGE | tr -d '%') 
THRESHOLD=80

echo "CHECKED   : $CURRENT_DATE"
echo "Threshold : ${THRESHOLD}%"
echo "DISK (/)  : $DISK_USAGE"
echo "================================================"
if [ $DISK_NUM -gt $THRESHOLD ]; then
    echo "STATUS    :  ALERT — Disk usage critical: ${DISK_NUM}% used"
else
    echo "STATUS    :  Disk usage within safe limits"
fi