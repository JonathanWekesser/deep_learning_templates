#!/bin/bash
set -euo pipefail

PROFILE=$1

if [ "$PROFILE" = "cpu" ]; then
    docker compose --profile cpu up -d
elif [ "$PROFILE" = "nvidia" ]; then
    docker compose --profile nvidia up -d
elif [ "$PROFILE" = "amd" ]; then
    docker compose --profile amd up -d
else
    echo "Usage: $0 [cpu|nvidia|amd]"
    exit 1
fi
