FROM summerwind/actions-runner:v2.286.0-ubuntu-20.04

USER root

ENV SKOPEO_VERSION 100:1.3.0-1
ENV YQ_VERSION v4.16.2

RUN mkdir -p /tmp/aws \
  && cd /tmp/aws \
  && curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
  && unzip awscliv2.zip \
  && ./aws/install \
  && rm -rf /tmp/aws

RUN . /etc/os-release \
  && echo "deb https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/xUbuntu_${VERSION_ID}/ /" \
  | tee /etc/apt/sources.list.d/devel:kubic:libcontainers:stable.list \
  && curl -L https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/xUbuntu_${VERSION_ID}/Release.key \
  | apt-key add - \
  && apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get -y --no-install-recommends install skopeo=${SKOPEO_VERSION} \
  && wget -O /usr/local/bin/yq https://github.com/mikefarah/yq/releases/download/${YQ_VERSION}/yq_linux_amd64 \
  && chmod +x /usr/local/bin/yq \
  && rm -rf /var/lib/apt/lists/*

USER runner
