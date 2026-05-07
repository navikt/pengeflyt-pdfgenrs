#!/bin/bash

CURRENT_PATH="$(cd "$(dirname "$0")" && pwd)"
BASEIMG="$(grep '^FROM ' "$CURRENT_PATH/Dockerfile" | head -n 1 | awk '{print $2}')"

docker pull "$BASEIMG"
docker run \
        -v $CURRENT_PATH/templates:/app/templates \
        -v $CURRENT_PATH/fonts:/app/fonts \
        -v $CURRENT_PATH/data:/app/data \
        -v $CURRENT_PATH/resources:/app/resources \
        -v $CURRENT_PATH/resources:/app/templates/resources \
        -p 8080:8080 \
        -e DEV_MODE=true \
        -it \
        --rm \
        "$BASEIMG"
