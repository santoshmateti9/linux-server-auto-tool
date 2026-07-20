#!/bin/bash

# -----------------------------
# Disk Usage Monitor
# Author: Santosh Mateti
# -----------------------------

THRESHOLD=80
LOG_FILE="logs/disk_usage.log"
REPORT_FILE="reports/disk_report.txt"

mkdir -p logs reports

echo "===== Disk Usage Report =====" > "$REPORT_FILE"
date >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

echo "Checking disk usage..."

df -h | awk 'NR>1 {print $1, $5, $6}' | while read filesystem usage mount
do
    percent=$(echo "$usage" | tr -d '%')

    echo "$filesystem mounted on $mount is using $usage"

    echo "$filesystem $usage $mount" >> "$REPORT_FILE"

    if [ "$percent" -ge "$THRESHOLD" ]; then
        echo "WARNING: $filesystem is above ${THRESHOLD}% usage!"

        echo "$(date '+%Y-%m-%d %H:%M:%S') - WARNING - $filesystem reached $usage" >> "$LOG_FILE"
    fi
done

echo ""
echo "Report saved to $REPORT_FILE"
echo "Log saved to $LOG_FILE"
