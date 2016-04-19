#!/bin/sh
export DISPLAY=:99
export SE_OPTS="-ensureCleanSession -trustAllSSLCertificates"
export SCREEN_WIDTH=1280
export SCREEN_HEIGHT=1024
export SCREEN_DEPTH=16
export GEOMETRY="$SCREEN_WIDTH""x""$SCREEN_HEIGHT""x""$SCREEN_DEPTH"
export PATH="/usr/bin:/opt/firefox:/opt/bin:$PATH"
LOG="/var/log/selenium/xvfb.log"

function shutdown {
  kill -s SIGTERM $NODE_PID
  wait $NODE_PID
}

if [ ! -z "$SE_OPTS" ]; then
  echo "appending selenium options: ${SE_OPTS}"
fi

xvfb-run \
  -e $LOG \
  --wait=5 \
  --server-num=99 \
  --server-args="-screen 0 $GEOMETRY -ac +extension RANDR" \
  java -jar /opt/selenium/selenium-server-standalone.jar \
  ${SE_OPTS} &
NODE_PID=$!

trap shutdown SIGTERM SIGINT
wait $NODE_PID
