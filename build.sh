#!/bin/bash
set -euo pipefail

PROFILE=$1

if [ "$PROFILE" = "cpu" ]; then
    docker compose --profile cpu build
elif [ "$PROFILE" = "nvidia" ]; then
    docker compose --profile nvidia build
elif [ "$PROFILE" = "amd" ]; then
    docker compose --profile amd build
else
    echo "Usage: $0 [cpu|nvidia|amd]"
    exit 1
fi
