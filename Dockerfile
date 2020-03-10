FROM koenkk/zigbee2mqtt:latest

# Install socat
RUN apk add --no-cache --virtual tini socat

RUN mkdir /runwatch
COPY runwatch/run.sh /runwatch/run.sh
# Monitor socat
COPY runwatch/100.socat-deconz.enabled.sh /runwatch/100.socat-deconz.enabled.sh
# Monitor Zigbee2mqtt
COPY runwatch/200.deconz.enabled.sh /runwatch/200.deconz.enabled.sh
RUN chmod 777 /runwatch/*.sh

ENTRYPOINT [ "/tini", "--", "/runwatch/run.sh" ]

