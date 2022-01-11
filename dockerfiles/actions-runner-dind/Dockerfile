FROM summerwind/actions-runner-dind:v2.286.0-ubuntu-20.04

USER root

ARG helm_version=3.7.2

ENV SKOPEO_VERSION=100:1.3.0-1
ENV YQ_VERSION=v4.16.2
ENV HELM_VERSION="${helm_version:-3.7.2}"
ENV DEBIAN_FRONTEND=noninteractive

RUN mkdir -p /tmp/aws \
  && cd /tmp/aws \
  && curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
  && unzip awscliv2.zip \
  && ./aws/install \
  && rm -rf /tmp/aws

RUN . /etc/os-release \
  && export ARCH=$(dpkg --print-architecture) \
  && echo "deb https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/xUbuntu_${VERSION_ID}/ /" \
  | tee /etc/apt/sources.list.d/devel:kubic:libcontainers:stable.list \
  && curl -L https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/xUbuntu_${VERSION_ID}/Release.key \
  | apt-key add - \
  && apt-get update \
  && apt-get -y --no-install-recommends install skopeo=${SKOPEO_VERSION} \
  && wget https://github.com/mikefarah/yq/releases/download/${YQ_VERSION}/yq_linux_${ARCH} -O /usr/local/bin/yq  \
  && wget https://get.helm.sh/helm-v${HELM_VERSION}-linux-${ARCH}.tar.gz -O - | tar -xz -C /tmp \
  && mv /tmp/linux-${ARCH}/helm /usr/local/bin \
  && chmod +x /usr/local/bin/yq \
  && rm -rf /var/lib/apt/lists/* /tmp/linux-${ARCH}

USER runner
