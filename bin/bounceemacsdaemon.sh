#!/bin/bash
# Development DB Script.
echo "locating emacs dameon PID, xarging it to kill..."
ps aux | grep macs | grep -v grep | awk '{print $2}' | xargs kill && /usr/local/bin/emacs --daemon
echo "Starting emacs Daemon..."
/usr/local/bin/emacs --daemon
echo "Started"

