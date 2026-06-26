#!/bin/bash

echo "================================================"
echo "       SRE TOOLKIT — Port Check"
echo "================================================"

PORT=64433
PORT_STATUS=$(netstat -an | grep "$PORT" | grep LISTEN)
echo "$PORT_STATUS"

if [ -z "$PORT_STATUS" ]; then
    echo "STATUS : port is closed"
else
    echo "STATUS : PORT is open"
fi