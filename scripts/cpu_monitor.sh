#!/bin/bash

# -----------------------------
# CPU Monitor
# Author: Santosh Mateti
# -----------------------------

THRESHOLD=2.00
LOG_FILE="logs/cpu_usage.log"
REPORT_FILE="reports/cpu_report.txt"

mkdir -p logs reports

echo "===== CPU Report =====" > "$REPORT_FILE"
date >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

UPTIME=$(uptime -p)
LOAD=$(uptime | awk -F'load average:' '{print $2}' | cut -d',' -f1 | xargs)

echo "System Uptime : $UPTIME"
echo "CPU Load      : $LOAD"

{
echo "System Uptime : $UPTIME"
echo "CPU Load      : $LOAD"
} >> "$REPORT_FILE"

if awk "BEGIN {exit !($LOAD > $THRESHOLD)}"
then
    echo "WARNING: CPU load is above $THRESHOLD"

    echo "$(date '+%Y-%m-%d %H:%M:%S') - WARNING - CPU load is $LOAD" >> "$LOG_FILE"
fi

echo ""
echo "Report saved to $REPORT_FILE"
echo "Log saved to $LOG_FILE"
