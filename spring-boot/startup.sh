#!/bin/sh
JRE_PATH="/home/app/bin/zulu17/bin/java"
JAR_PATH="/home/app/application.jar"
LOG_PATH="/home/app/application.log"
PROFILE_NAME=${1:-prod}

if [ -f "$JAR_PATH" ]; then
    $JRE_PATH -Dfile.encoding=UTF-8 -Djava.net.preferIPv4Stack=true -jar $JAR_PATH --spring.profiles.active=$PROFILE_NAME > $LOG_PATH 2>&1 &
else
    echo "Application JAR file not found."
fi