#!/usr/bin/env bash
set -euo pipefail

if [[ $# -eq 0 ]]; then
  echo "Usage: ./pattern.sh make <target>"
  exit 1
fi

if [[ "$1" == "make" ]]; then
  shift
  exec make "$@"
fi

exec "$@"
