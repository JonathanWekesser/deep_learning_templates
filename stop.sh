#!/bin/bash
set -euo pipefail

# Usage: ./stop.sh [cpu|nvidia|amd|all]
# Optional: TIMEOUT=15 ./stop.sh nvidia

PROFILE="${1:-}"
[[ -z "${PROFILE}" ]] && { echo "Usage: $0 [cpu|nvidia|amd|all]"; exit 1; }
TIMEOUT="${TIMEOUT:-10}"

if [[ "${PROFILE}" == "all" ]]; then
  docker compose stop -t "${TIMEOUT}"
  exit 0
fi

docker compose --profile "${PROFILE}" stop -t "${TIMEOUT}"
echo "Stopped profile: ${PROFILE}"
