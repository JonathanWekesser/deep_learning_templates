#!/usr/bin/env bash
set -euo pipefail

# Usage: ./stop.sh [cpu|nvidia|amd|all]
# Optional: TIMEOUT=15 ./stop.sh nvidia

# ins Repo-Root wechseln (Skript liegt z. B. im Repo-Root oder in scripts/)
cd "$(dirname "$0")" >/dev/null 2>&1
# wenn du das Skript in scripts/ liegen hast, dann:
# cd ..

PROFILE="${1:-}"
[[ -z "${PROFILE}" ]] && { echo "Usage: $0 [cpu|nvidia|amd|all]"; exit 1; }
TIMEOUT="${TIMEOUT:-10}"

# .env einlesen (falls COMPOSE_PROJECT_NAME etc. gesetzt sind)
if [[ -f .env ]]; then
  # shellcheck disable=SC2046
  export $(grep -v '^#' .env | xargs -r)
fi

PROJECT_NAME="${COMPOSE_PROJECT_NAME:-$(basename "$PWD")}"

if [[ "${PROFILE}" == "all" ]]; then
  echo ">> docker compose down (all) ..."
  docker compose down -t "${TIMEOUT}" --remove-orphans || true
else
  echo ">> docker compose down for profile=${PROFILE} ..."
  # down entfernt standardmäßig das ganze Projekt; wenn du gezielt nur Services
  # eines Profils stoppen willst, kannst du hier auf 'stop' wechseln – aber
  # 'down' ist robuster gegen Waisen.
  docker compose --profile "${PROFILE}" down -t "${TIMEOUT}" --remove-orphans || true
fi

# Sicherheit: evtl. übrig gebliebene Container/Netze des Projekts entfernen
ids="$(docker ps -aq --filter "label=com.docker.compose.project=${PROJECT_NAME}")"
[[ -n "${ids}" ]] && docker rm -f ${ids} || true

net_ids="$(docker network ls -q --filter "label=com.docker.compose.project=${PROJECT_NAME}")"
[[ -n "${net_ids}" ]] && docker network rm ${net_ids} || true

echo ">> Remaining containers labeled with project=${PROJECT_NAME}:"
docker ps --filter "label=com.docker.compose.project=${PROJECT_NAME}"
