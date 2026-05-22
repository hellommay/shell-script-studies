#!/bin/bash

echo "========================================="
echo "       SYSTEM MONITORING REPORT          "
echo "========================================="
echo "Report generated on: $(date)"
echo ""

echo "Network Usage: "
sudo iftop -t -s 2
echo ""

echo "Disk Usage: "
df -h
echo ""

echo "System Uptime: "
uptime
echo ""

echo "1-Minute Load Average: "
top -bn1 | grep load | awk '{printf "%.2f<br>", $(NF-2)}'
echo ""

echo "RAM Usage: "
free -m | awk 'NR==2{printf "Memory Usage: %.2f%%<br>", $3*100/$2 } '

echo "========================================="
