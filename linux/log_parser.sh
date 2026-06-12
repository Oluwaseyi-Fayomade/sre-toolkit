#!/bin/bash

echo "================================================"
echo "       SRE TOOLKIT — Log Parser"
echo "================================================"

LOG_FILE="/Users/mac/sre-toolkit/linux/sample.log"
ANALYSED=$(date "+%Y-%m-%d %H:%M:%S")
COUNTS=$(wc -l < $LOG_FILE)
ERROR=$(grep -c "ERROR" $LOG_FILE )
WARNING=$(grep -c "WARNING" $LOG_FILE)
INFO=$(grep -c "INFO" $LOG_FILE)
LAST_ERRORS=$(grep "ERROR" $LOG_FILE | tail -5)

echo "Log file       : $LOG_FILE"
echo "Analysed       : $ANALYSED"
echo "------------------------------------------------"
echo "Total count    : $COUNTS"
echo "ERROR count    : $ERROR"
echo "WARNING count  : $WARNING"
echo "INFO count     : $INFO"
echo "------------------------------------------------"
echo "LAST 5 ERRORS:"
echo "$LAST_ERRORS"
echo "------------------------------------------------"
if [ $ERROR -gt 0 ]; then
echo "STATUS         : ⚠ Errors detected — review required"
else
    echo "STATUS         : ✓ All checks passed"
fi
echo "================================================"