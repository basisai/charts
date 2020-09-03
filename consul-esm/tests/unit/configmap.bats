#!/usr/bin/env bats

load _helpers

############################################################
# TLS
############################################################
@test "configmap/consul-esm: CA File is configured correctly" {
  cd `chart_dir`

  local config=$(helm template \
      --show-only templates/configmap.yaml  \
      --set 'config.tls.enabled=true' \
      . | tee /dev/stderr |
      yq -r '.data."config.hcl"' | tee /dev/stderr)

  local actual=$(echo "${config}" |
      grep 'ca_file' | tee /dev/stderr |
      wc -l | tee /dev/stderr)

  [ "${actual}" = '0' ]

  local config=$(helm template \
      --show-only templates/configmap.yaml  \
      --set 'config.tls.enabled=true' \
      --set 'config.tls.cacert=foobar' \
      . | tee /dev/stderr |
      yq -r '.data."config.hcl"' | tee /dev/stderr)

  local actual=$(echo "${config}" |
      grep 'ca_file = "/config/server.pem"' | tee /dev/stderr |
      wc -l | tee /dev/stderr)

  [ "${actual}" = '1' ]

  local config=$(helm template \
      --show-only templates/configmap.yaml  \
      --set 'config.tls.enabled=true' \
      --set 'config.tls.autoEncrypt.enabled=true' \
      . | tee /dev/stderr |
      yq -r '.data."config.hcl"' | tee /dev/stderr)

  local actual=$(echo "${config}" |
      grep 'ca_file = "/output/connect.pem"' | tee /dev/stderr |
      wc -l | tee /dev/stderr)

  [ "${actual}" = '1' ]
}

@test "configmap/server.pem: Server CA File is written" {
  cd `chart_dir`

  local actual=$(helm template \
      --show-only templates/configmap.yaml  \
      . | tee /dev/stderr |
      yq -r '.data."server.pem"' | tee /dev/stderr)

  [ "${actual}" = 'null' ]

  local actual=$(helm template \
      --show-only templates/configmap.yaml  \
      --set 'config.tls.cacert=foobar' \
      . | tee /dev/stderr |
      yq -r '.data."server.pem"' | tee /dev/stderr)

  [ "${actual}" = 'foobar' ]
}

@test "configmap/consul_template.hcl: File is written with autoencrypt" {
  cd `chart_dir`

  local actual=$(helm template \
      --show-only templates/configmap.yaml  \
      . | tee /dev/stderr |
      yq -r '.data."consul_template.hcl"' | tee /dev/stderr)

  [ "${actual}" = 'null' ]

  local actual=$(helm template \
      --show-only templates/configmap.yaml  \
      --set 'config.tls.enabled=true' \
      . | tee /dev/stderr |
      yq -r '.data."consul_template.hcl"' | tee /dev/stderr)

  [ "${actual}" = 'null' ]

  local actual=$(helm template \
      --show-only templates/configmap.yaml  \
      --set 'config.tls.enabled=true' \
      --set 'config.tls.autoEncrypt.enabled=true' \
      . | tee /dev/stderr |
      yq -r '.data."consul_template.hcl"' | tee /dev/stderr)

  [ "${actual}" != 'null' ]
}
