#!/usr/bin/env bash

if [[ -z "${SOCAT_DECONZ_TYPE}" ]]; then
  SOCAT_DECONZ_TYPE="tcp"
fi
if [[ -z "${SOCAT_DECONZ_LOG}" ]]; then
  SOCAT_DECONZ_LOG="-lf \"$SOCAT_DECONZ_LOG\""
fi
if [[ -z "${SOCAT_DECONZ_LINK}" ]]; then
  SOCAT_DECONZ_LINK="/dev/deconz"
fi

BINARY="socat"
PARAMS="$INT_SOCAT_LOG-d pty,link=$SOCAT_DECONZ_LINK,raw,user=root,mode=777 $SOCAT_DECONZ_TYPE:$SOCAT_DECONZ_HOST:$SOCAT_DECONZ_PORT"

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
        echo "stopping deconz since socat is not running"
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
