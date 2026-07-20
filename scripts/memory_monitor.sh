#!/bin/bash

# -----------------------------
# Memory Usage Monitor
# Author: Santosh Mateti
# -----------------------------

THRESHOLD=80
LOG_FILE="logs/memory_usage.log"
REPORT_FILE="reports/memory_report.txt"

mkdir -p logs reports

echo "===== Memory Usage Report =====" > "$REPORT_FILE"
date >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

total=$(free -m | awk '/Mem:/ {print $2}')
used=$(free -m | awk '/Mem:/ {print $3}')
free_mem=$(free -m | awk '/Mem:/ {print $4}')
usage_percent=$(( used * 100 / total ))

echo "Total Memory : ${total} MB"
echo "Used Memory  : ${used} MB"
echo "Free Memory  : ${free_mem} MB"
echo "Usage        : ${usage_percent}%"

{
echo "Total Memory : ${total} MB"
echo "Used Memory  : ${used} MB"
echo "Free Memory  : ${free_mem} MB"
echo "Usage        : ${usage_percent}%"
} >> "$REPORT_FILE"

if [ "$usage_percent" -ge "$THRESHOLD" ]; then
    echo "WARNING: Memory usage is above ${THRESHOLD}%"

    echo "$(date '+%Y-%m-%d %H:%M:%S') - WARNING - Memory usage is ${usage_percent}%" >> "$LOG_FILE"
fi

echo ""
echo "Report saved to $REPORT_FILE"
echo "Log saved to $LOG_FILE"
