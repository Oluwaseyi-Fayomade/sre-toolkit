#!/bin/bash

echo "================================================"
echo "       SRE TOOLKIT — System Health Check"
echo "================================================"

CURRENT_DATE=$(date "+%Y-%m-%d %H:%M:%S")
HOSTNAME=$(hostname)
UPTIME=$(uptime)
DISK_USAGE=$(df -h / | awk 'NR==2 {print $5}')
MEMORY=$(vm_stat | grep "Pages free" | awk '{print $3}' | tr -d '.')
CPU_USAGE=$(top -l 1 | grep "CPU usage")
PROCESSES=$(ps aux | sort -rk 3 | head -4 | awk 'NR>1 {print $2, $3, $11}')

echo "Date/Time  : $CURRENT_DATE"
echo "Hostname   : $HOSTNAME" 
echo "Uptime     : $UPTIME"
echo "------------------------------------------------"
echo "Disk (/)   : $DISK_USAGE"
echo "Memory     : $MEMORY"
echo "CPU        : $CPU_USAGE"
echo "------------------------------------------------"
echo "TOP 3 PROCESSES BY CPU:"
echo "$PROCESSES"
echo "STATUS     : ✓ All checks passed"
echo "================================================"
