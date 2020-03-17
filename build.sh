#!/bin/sh
DOCKER_REPO='mc303/zigbee2mqtt-socat-v2:dev'
BUIILDX_REPO='buildzigbee2mqttsocat'

#env DOCKER_BUILDKIT=1 
docker build --no-cache -t $DOCKER_REPO .


#create platform buildx env
# docker buildx create --platform linux/386,linux/amd64,linux/arm/v6,linux/arm/v7,linux/arm64 --name $BUIILDX_REPO
# docker buildx use $BUIILDX_REPO

# # build platforms
# docker buildx build --platform=linux/386,linux/amd64,linux/arm/v6,linux/arm/v7,linux/arm64 -t $DOCKER_REPO --push .

# # remove build env
# docker buildx rm $BUIILDX_REPO

