#!/bin/bash

# Path to the application.pid file
PID_FILE="/home/app/application.pid"
PORT=8080

# Check if the file exists
if [ -f "$PID_FILE" ]; then
  # Read the PID from the file
  PID=$(cat "$PID_FILE")

  # Try to kill the process
  if kill -0 $PID > /dev/null 2>&1; then
    kill $PID
    echo "Process $PID has been terminated."
  else
    echo "Process $PID does not exist."
  fi
else
  echo "$PID_FILE does not exist. Killing the process using port $PORT."

  # Find the PID of the process using port 8080 (using netstat)
  PID=$(netstat -tnlp | grep ":$PORT" | awk '{print $7}' | cut -d'/' -f1)

  if [ -n "$PID" ]; then
    # Kill the process
    kill $PID
    echo "Process $PID using port $PORT has been terminated."
  else
    echo "No process is using port $PORT."
  fi
fi