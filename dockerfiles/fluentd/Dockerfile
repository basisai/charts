FROM quay.io/fluentd_elasticsearch/fluentd:v3.2.0

RUN fluent-gem install digest-crc --version 0.5.1 \
  && fluent-gem install fluent-plugin-gcs --version 0.4.1 \
  && fluent-gem install fluent-plugin-s3 --version 1.6.0
