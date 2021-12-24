FROM quay.io/fluentd_elasticsearch/fluentd:v3.3.0

RUN fluent-gem install digest-crc --version 0.6.4 --no-document \
  && fluent-gem install fluent-plugin-gcs --version 0.4.1 --no-document \
  && fluent-gem install fluent-plugin-s3 --version 1.6.1 --no-document
