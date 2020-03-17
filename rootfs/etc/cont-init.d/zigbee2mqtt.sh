#!/usr/bin/with-contenv bash


if [ ! -z "$ZIGBEE2MQTT_DATA" ]; then
    DATA="$ZIGBEE2MQTT_DATA"
else
    DATA="/app/data"
fi

echo "Using '$DATA' as data directory"

if [ ! -f "$DATA/configuration.yaml" ]; then
    echo "Creating configuration file..."
    cp /app/configuration.yaml "$DATA/configuration.yaml"

    sed -i 's:/dev/ttyACM0:'$SOCAT_ZIGBEE_LINK':g' "$DATA/configuration.yaml"
fi


