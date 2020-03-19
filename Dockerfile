FROM koenkk/zigbee2mqtt:latest as base

ARG TARGETPLATFORM
RUN echo "TARGETPLATFORM : $TARGETPLATFORM"

# Install socat
RUN \
    apk add --no-cache --virtual .build-dependencies \
        curl \
        tar \
    \
    && apk add --no-cache \
        socat \
        bash  \
        musl-utils \
    \
    && if [ "$TARGETPLATFORM" = "linux/386" ] ; then XARCH="x86" ; fi \
    && if [ "$TARGETPLATFORM" = "linux/amd64" ] ; then XARCH="amd64" ; fi \
    && if [ "$TARGETPLATFORM" = "linux/arm/v6" ] ; then XARCH="arm" ; fi \
    && if [ "$TARGETPLATFORM" = "linux/arm/v7" ] ; then XARCH="armhf" ; fi \
    && if [ "$TARGETPLATFORM" = "linux/arm64" ] ; then XARCH="aarch64" ; fi \
    \
    && curl -L -s "https://github.com/just-containers/s6-overlay/releases/download/v1.22.1.0/s6-overlay-$XARCH.tar.gz" \
        | tar zxvf - -C / \
    \
    && mkdir -p /etc/fix-attrs.d \
    && mkdir -p /etc/services.d \
    \
    && apk del --no-cache --purge .build-dependencies \
    && rm -fr \
        /tmp/* 
        
# Entrypoint & CMD
ENTRYPOINT ["/init"]

# Copy root filesystem
COPY rootfs /


