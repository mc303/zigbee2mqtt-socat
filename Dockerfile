FROM koenkk/zigbee2mqtt:latest

# Install socat
RUN apk add --no-cache --virtual tini socat bash

RUN mkdir /runwatch
COPY runwatch/run.sh /runwatch/run.sh
# Monitor socat
COPY runwatch/100.socat-zigbee.enabled.sh /runwatch/100.socat-zigbee2mqtt.enabled.sh
# Monitor Zigbee2mqtt
COPY runwatch/200.zigbee2mqtt.enabled.sh /runwatch/200.zigbee2mqtt.enabled.sh
RUN chmod 777 /runwatch/*.sh

ENTRYPOINT [ "/sbin/tini", "--", "/runwatch/run.sh" ]

