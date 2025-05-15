#!/bin/sh
PORT=8080

check_port() {
  netstat -tuln | grep ":$PORT" > /dev/null
  return $?
}

check_port

if [ $? -ne 0 ]; then
  echo "Port $PORT is not open. Executing script..."
  cd /home/app
  sh /home/app/bin/startup.sh
else
  echo "Port $PORT is open. No need to execute the script."
fi