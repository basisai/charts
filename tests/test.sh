#!/usr/bin/env bash
set -euo pipefail

BATS_IMAGE="${BATS_IMAGE:-basisai/bats-helm:v1.2.1}"

# consul-esm
docker run --rm -v "$(git rev-parse --show-toplevel)/charts/consul-esm:/tests" --workdir "/tests" \
    "${BATS_IMAGE}" \
    bats tests/unit
