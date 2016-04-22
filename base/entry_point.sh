#!/bin/sh
export PATH="/usr/bin:/opt/firefox:/opt/bin:$PATH"
export DISPLAY=:99
export SCREEN_WIDTH=1280
export SCREEN_HEIGHT=1024
export SCREEN_DEPTH=16
export GEOMETRY="$SCREEN_WIDTH""x""$SCREEN_HEIGHT""x""$SCREEN_DEPTH"
export SE_OPTS="-ensureCleanSession -trustAllSSLCertificates"
export X_OPTS="$DISPLAY -ac -screen 0 $GEOMETRY +extension RANDR"
export X_LOG="/var/log/selenium/xvfb.log"

function shutdown {
  kill -s SIGTERM $NODE_PID $X_PID
  wait $NODE_PID $X_PID
}

if [ ! -z "$SE_OPTS" ]; then
  echo "appending selenium options: ${SE_OPTS}"
fi

Xvfb $X_OPTS >>$X_LOG 2>&1 &
X_PID=$!
java -jar /opt/selenium/selenium-server-standalone.jar ${SE_OPTS} &
NODE_PID=$!

trap shutdown SIGTERM SIGINT
wait $NODE_PID $X_PID
