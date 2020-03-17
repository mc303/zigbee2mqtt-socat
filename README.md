# zigbee2mqtt with socat for remote zigbee

changed from deconz-socat to zigbee2mqtt-socat and changed to latest branch fork from [deconz-socat](https://github.com/peterforeman/deconz-socat)

Instead of using a locally-connected zigbee device (usbstick/CC2531), we can use a serial device mapped over the network with ser2net or socat and then map it to a local zwave serial device with socat.

Please [report issues on github](https://github.com/mc303/zigbee2mqtt-socat/issues).

## Getting Started

This docker container ensures that:
 - socat is running
 - zigbee2mqtt is running

If there are any failures, both socat and zigbee2mqtt will be restarted.

### Prerequisites

See the normal zigbee2mqtt docker container readme.

### Installing

The container needs some extra parameters as described below.

All [koenkk-zigbee2mqtt](https://hub.docker.com/r/koenkk/zigbee2mqtt/) image options are available and on top of that a few others have been added.

# Socat options

**SOCAT_ZIGBEE_TYPE**="tcp"

**SOCAT_ZIGBEE_HOST**="192.168.5.5"

**SOCAT_ZIGBEE_PORT**="7676"

Where socat should connect to. Will be used as tcp://192.168.5.5:7676

**SOCAT_ZIGBEE_LINK**="/dev/zigbee"

What the zigbee device should be mapped to. Use this in your zigbee2mqtt configuration file.

## Deployment

Example socat on host system:
```
/usr/bin/socat -d pty,b115200,raw,echo=0,link=/dev/zigbee tcp:192.168.1.178.10:20108
```

## Acknowledgements

based on [peterforeman-deconz-socat](https://hub.docker.com/r/peterforeman/deconz-socat) image [published on docker hub](https://hub.docker.com/r/peterforeman/deconz-socat).

Based on [koenkk-zigbee2mqtt](https://hub.docker.com/r/koenkk/zigbee2mqtt/) image, [published on docker hub](https://hub.docker.com/r/koenkk/zigbee2mqtt).

Based on [vladbabii/homeassistant-socat](https://hub.docker.com/r/vladbabii/homeassistant-socat).

# zigbee2mqtt-socat
