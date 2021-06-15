# fluentd

[Fluentd](https://www.fluentd.org/) collects events from various data sources and writes them to files, RDBMS, NoSQL, IaaS, SaaS, Hadoop and so on. Fluentd helps you unify your logging infrastructure (Learn more about the Unified Logging Layer).

This chart originates from https://github.com/helm/charts/tree/269d7791a5ddb8622e66e02e3fff756a4cdbf4f9/stable/fluentd

## Configuration

The following table lists the configurable parameters of the fluentd chart and their default values.

Parameter | Description | Default
--- | --- | ---
`useStatefulSet` | Deploy as a StatefulSet regardless of whether autoscaling is enabled | `nil`
`affinity` | node/pod affinities | `{}`
`configMaps` | Fluentd configuration | See [values.yaml](values.yaml)
`image.pullPolicy` | Image pull policy | `IfNotPresent`
`image.repository` | Image repository | `gcr.io/google-containers/fluentd-elasticsearch`
`image.tag` | Image tag | `v2.4.0`
`imagePullSecrets` | Specify image pull secrets | `nil` (does not add image pull secrets to deployed pods)
`extraEnvVars` | Adds additional environment variables to the deployment (in yaml syntax) | `{}` See [values.yaml](values.yaml)
`extraVolumeMounts` | Mount extra volumes (in yaml syntax) | `` See [values.yaml](values.yaml)
`extraVolumes` | Extra volumes (in yaml syntax) | `` See [values.yaml](values.yaml)
`ingress.enabled` | enable ingress | `false`
`ingress.labels` | list of labels for the ingress rule | See [values.yaml](values.yaml)
`ingress.annotations` | list of annotations for the ingress rule | `kubernetes.io/ingress.class: nginx` See [values.yaml](values.yaml)
`ingress.hosts` | host definition for ingress | See [values.yaml](values.yaml)
`ingress.tls` | tls rules for ingress | See [values.yaml](values.yaml)
`nodeSelector` | node labels for pod assignment | `{}`
`replicaCount` | desired number of pods | `1` ???
`resources` | pod resource requests & limits | `{}`
`plugins.enabled` | Enable Plugins Installation | `false`
`plugins.pluginsList` | List of plugins to install | `[]`
`rbac.create` | Specifies whether RBAC resources should be created | `true`
`serviceAccount.create` | Specifies whether a service account should be created. | `true`
`serviceAccount.name` | Name of the service account.
`priorityClassName` | priorityClassName | `nil`
`service.loadBalancerIP` | If `service.type` is `LoadBalancer` set custom IP load balancer IP address | `nil`
`service.ports` | port definition for the service | See [values.yaml](values.yaml)
`service.type` | type of service | `ClusterIP`
`service.annotations` | list of annotations for the service | `{}`
`service.sessionAffinity` | Session affinity type for the service | `None`
`service.sessionAffinityConfig.timeoutSeconds` | ClientIP type session affinity timeout duration in seconds. | `nil`
`tolerations` | List of node taints to tolerate | `[]`
`persistence.enabled` | Enable buffer persistence | `false`
`persistence.accessMode` | Access mode for buffer persistence | `ReadWriteOnce`
`persistence.size` | Volume size for buffer persistence | `10Gi`
`autoscaling.enabled` | Set this to `true` to enable autoscaling | `false`
`autoscaling.minReplicas` | Set minimum number of replicas | `2`
`autoscaling.maxReplicas` | Set maximum number of replicas | `5`
`autoscaling.metrics` | metrics used for autoscaling | See [values.yaml](values.yaml)
`terminationGracePeriodSeconds` | Optional duration in seconds the pod needs to terminate gracefully | `30`
`metrics.enabled`                         | Set this to `true` to enable Prometheus metrics HTTP endpoint                         | `false`
`metrics.service.port`                    | Prometheus metrics HTTP endpoint port                                                 | `24231`
`metrics.serviceMonitor.enabled`          | Set this to `true` to create ServiceMonitor for Prometheus operator                   | `false`
`metrics.serviceMonitor.additionalLabels` | Additional labels that can be used so ServiceMonitor will be discovered by Prometheus | `{}`
`metrics.serviceMonitor.namespace`        | Optional namespace in which to create ServiceMonitor                                  | `nil`
`metrics.serviceMonitor.interval`         | Scrape interval. If not set, the Prometheus default scrape interval is used           | `nil`
`metrics.serviceMonitor.scrapeTimeout`    | Scrape timeout. If not set, the Prometheus default scrape timeout is used             | `nil`
