FROM google/cloud-sdk:251.0.0

ARG ansible_version=2.8.1

RUN set -xe \
    && apt-get update \
    && apt-get install -y unzip \
    && pip install "ansible==${ansible_version}" \
    && ansible --version \
    && gsutil --version

WORKDIR /opt/backup
COPY ./ ./

CMD ["ansible-playbook", "-i", "localhost," "--connection", "local", "site.yml"]
