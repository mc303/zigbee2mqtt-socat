#!/bin/sh
docker buildx build --platform=linux/386,linux/amd64,linux/arm/v6,linux/arm/v7,linux/arm64 -t mc303/zigbee2mqtt-socat --push .

