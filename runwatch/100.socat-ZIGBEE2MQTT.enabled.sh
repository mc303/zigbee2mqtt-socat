#!/usr/bin/env bash

if [[ -z "${SOCAT_ZIGBEE2MQTT_TYPE}" ]]; then
  SOCAT_ZIGBEE2MQTT_TYPE="tcp"
fi
if [[ -z "${SOCAT_ZIGBEE2MQTT_LOG}" ]]; then
  SOCAT_ZIGBEE2MQTT_LOG="-lf \"$SOCAT_ZIGBEE2MQTT_LOG\""
fi
if [[ -z "${SOCAT_ZIGBEE2MQTT_LINK}" ]]; then
  SOCAT_ZIGBEE2MQTT_LINK="/dev/zigbee"
fi

BINARY="socat"
PARAMS="$INT_ZIGBEE2MQTT_LOG-d pty,link=$SOCAT_ZIGBEE2MQTT_LINK,raw,user=root,mode=777 $SOCAT_ZIGBEE2MQTT_TYPE:$SOCAT_ZIGBEE2MQTT_HOST:$SOCAT_ZIGBEE2MQTT_PORT"

######################################################

CMD=$1

if [[ -z "${CONFIG_LOG_TARGET}" ]]; then
  LOG_FILE="/dev/null"
else
  LOG_FILE="${CONFIG_LOG_TARGET}"
fi

case $CMD in

describe)
    echo "Sleep $PARAMS"
    ;;

## exit 0 = is not running
## exit 1 = is running
is-running)
    if pgrep -f "$BINARY $PARAMS" >/dev/null 2>&1 ; then
        exit 1
    fi
    # stop deconz if socat is not running 
    if pgrep -f "start.sh" >/dev/null 2>&1 ; then
        echo "stopping zigbee2mqtt since socat is not running"
        kill -9 $(pgrep -f "start.sh")
    fi
    exit 0
    ;;

start)
    echo "Starting... $BINARY $PARAMS" >> "$LOG_FILE"
    $BINARY $PARAMS 2>$LOG_FILE >$LOG_FILE &
    # delay other checks for 5 seconds
    sleep 5
    ;;

start-fail)
    echo "Start failed! $BINARY $PARAMS"
    ;;

stop)
    echo "Stopping... $BINARY $PARAMS"
    kill -9 $(pgrep -f "$BINARY $PARAMS")
    ;;

esac
