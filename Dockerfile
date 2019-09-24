FROM marthoc/deconz:latest
LABEL maintainer="Peter Foreman <peter@frmn.nl>"

# Install socat
RUN apt-get update && apt-get -y install socat

RUN mkdir /runwatch
COPY runwatch/run.sh /runwatch/run.sh
# Monitor socat
COPY runwatch/100.socat-deconz.enabled.sh /runwatch/100.socat-deconz.enabled.sh
# Monitor Zigbee2mqtt
COPY runwatch/200.deconz.enabled.sh /runwatch/200.deconz.enabled.sh
RUN chmod 777 /runwatch/*.sh

ENTRYPOINT [ "/tini", "--", "/runwatch/run.sh" ]

