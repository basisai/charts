#!/usr/bin/env bats

load _helpers

############################################################
# Daemonset Consul Agent
############################################################
@test "deployment: Daemonset Consul Agent Environment variables are set" {
  cd `chart_dir`

  local actual=$(helm template \
      --show-only templates/deployment.yaml  \
      --set 'config.useNodeAgent.enabled=false' \
      . | tee /dev/stderr |
      yq -r '.spec.template.spec.containers[0].env | length' | tee /dev/stderr)

  [ "${actual}" = '0' ]

  local env=$(helm template \
      --show-only templates/deployment.yaml  \
      --set 'config.useNodeAgent.enabled=true' \
      . | tee /dev/stderr |
      yq -r '.spec.template.spec.containers[0].env' | tee /dev/stderr)
  local actual=$(echo "${env}" | \
      jq -r 'length' | tee /dev/stderr)
  [ "${actual}" = '2' ]

  local actual=$(echo "${env}" | \
      jq -r '.[0].name' | tee /dev/stderr)
  [ "${actual}" = 'HOST_IP' ]

  local actual=$(echo "${env}" | \
      jq -r '.[1].name' | tee /dev/stderr)
  [ "${actual}" = 'CONSUL_HTTP_ADDR' ]
}

############################################################
# TLS
############################################################
@test "deployment: Init Container for auto encrypt is present" {
  cd `chart_dir`

  local actual=$(helm template \
      --show-only templates/deployment.yaml  \
      . | tee /dev/stderr |
      yq -r '.spec.template.spec.initContainers | length' | tee /dev/stderr)

  [ "${actual}" = '1' ]

  local actual=$(helm template \
      --show-only templates/deployment.yaml  \
      --set 'config.tls.enabled=true' \
      . | tee /dev/stderr |
      yq -r '.spec.template.spec.initContainers | length' | tee /dev/stderr)

  [ "${actual}" = '1' ]

  local actual=$(helm template \
      --show-only templates/deployment.yaml  \
      --set 'config.tls.enabled=true' \
      --set 'config.tls.autoEncrypt.enabled=true' \
      . | tee /dev/stderr |
      yq -r '.spec.template.spec.initContainers | length' | tee /dev/stderr)

  [ "${actual}" = '2' ]
}

@test "deployment: Consul Template Container for auto encrypt is present" {
  cd `chart_dir`

  local actual=$(helm template \
      --show-only templates/deployment.yaml  \
      . | tee /dev/stderr |
      yq -r '.spec.template.spec.containers | length' | tee /dev/stderr)

  [ "${actual}" = '1' ]

  local actual=$(helm template \
      --show-only templates/deployment.yaml  \
      --set 'config.tls.enabled=true' \
      . | tee /dev/stderr |
      yq -r '.spec.template.spec.containers | length' | tee /dev/stderr)

  [ "${actual}" = '1' ]

  local actual=$(helm template \
      --show-only templates/deployment.yaml  \
      --set 'config.tls.enabled=true' \
      --set 'config.tls.autoEncrypt.enabled=true' \
      . | tee /dev/stderr |
      yq -r '.spec.template.spec.containers | length' | tee /dev/stderr)

  [ "${actual}" == '2' ]
}
