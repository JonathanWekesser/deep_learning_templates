#!/bin/bash
set -euo pipefail
# navigate to repo root
cd "$(dirname "$0")" >/dev/null 2>&1

PROFILE="${1:-}"
[[ -z "${PROFILE}" ]] && { echo "Usage: $0 [cpu|nvidia|amd]"; exit 1; }

docker compose --profile "${PROFILE}" up -d
