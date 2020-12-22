FROM quay.io/fluentd_elasticsearch/fluentd:v2.9.0

RUN fluent-gem install digest-crc --version 0.5.1 \
  && fluent-gem install fluent-plugin-gcs \
  && fluent-gem install fluent-plugin-s3
