# Changelog — generic-service

All notable changes to this chart will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html) beginning after 2.0.0.

> **Note on version suffixes:** The 2.0.0 and previous pre-release series used Greek letter suffixes (alpha < beta < charlie < delta) as a stand-in for pre-release versioning during rapid iteration. `2.0.0-alpha` was a pre-release of `2.0.0`.

> **Note on 1.0.x history:** The 1.0.x series was developed through rapid iteration in August–January 2023–2024. Many patch versions within this range were same-day fixes with non-descriptive commit messages. Entries for these versions reflect the best available reconstruction from git history.

> **Note on 1.999.1:** This tag (2023-09-11) was an experimental version created during the 1.0.x development period. It is not part of the normal release sequence and should not be used.

## [Unreleased]

## [2.0.0-alpha] - 2025-07-25

### Added

- HorizontalPodAutoscaler (HPA) support for frontend and worker deployments, configurable per deployment via `autoscaling.enabled`, `autoscaling.maxReplicaCount`, `autoscaling.cpuUtilizationPercentage`, and `autoscaling.memoryUtilizationPercentage`.
- `autoscaling.minReplicaCount` falls back to `replicaCount` when HPA is enabled.

### Changed

- **Breaking:** Resource values are now specified as unitless integers. The template appends `m` (millicores) and `Mi` (mebibytes) automatically. Values previously set as `cpu: "100m"` must be changed to `cpu: 100`; `memory: "512Mi"` must be changed to `memory: 512`.

## [1.1.6-delta] - 2025-07-17

### Added

- Support for multiple cronjobs via an array of `cronjob` entries.

## [1.1.6-charlie] - 2025-02-12

### Changed

- `DD_VERSION` extraction simplified: the hex hash detection introduced in `1.1.6-alpha` was removed. The tag is now always taken as everything after the colon in the image reference.

## [1.1.6-beta] - 2025-01-24

### Changed

- Flux `ImageUpdateAutomation` is now wrapped in a conditional to support deployments using ArgoCD instead of Flux.

## [1.1.6-alpha] - 2024-12-13

### Changed

- **Breaking:** `DD_VERSION` is no longer read from the top-level `version:` value. It is now extracted automatically from the image tag: first attempting to match an 8-character hex hash suffix (short SHA), falling back to everything after the colon. The top-level `version:` field is no longer used by the chart.

## [1.1.5] - 2024-10-07

### Added

- Datadog log source annotation (`ad.datadoghq.com/<name>.logs`) added to pod template spec.

### Changed

- **Breaking:** Container name is now set to `$value.name` per deployment. Previously it was hardcoded to `generic-service` (the chart name) for all deployments. Upgrading will recreate pods and change Datadog container tagging.
- **Breaking:** `ImageUpdateAutomation` API version updated from `image.toolkit.fluxcd.io/v1beta1` to `v1beta2`. Clusters must have the Flux v1beta2 CRD installed before upgrading.

## [1.1.4] - 2024-08-01

### Added

- Docker registry support in `ImagePolicy`, using semver ordering when `repositoryType: docker` is set.
- Conditional `imagePullSecret` for private Docker registries.
- 1Password integration via `OnePasswordItem` CRD for secret management.
- `secretType` field on `OnePasswordItem` resources, defaulting to `opaque`.

### Changed

- **Breaking:** Deployments using `loadBalancer.type: preexisting` must add `servicePort` to their values. Previously the container `port` value was used as the service port; it now defaults to `80` if `servicePort` is not set.

## [1.1.3] - 2024-06-11

### Added

- PersistentVolumeClaim volume support for the worker deployment.

### Changed

- **Breaking:** Volume values schema updated. `claimName` must now be nested under `persistentVolumeClaim`: change `volumes[n].claimName` to `volumes[n].persistentVolumeClaim.claimName` in both frontend and worker values.
- **Breaking:** Worker volumes are now sourced from `volumes` instead of `volumeMounts`. Rename the key in worker values accordingly.

### Fixed

- `ImageUpdateAutomation` reconciliation interval corrected.

## [1.1.2] - 2024-05-06

### Fixed

- Various fixes to `ImageUpdateAutomation` configuration.

## [1.1.1] - 2024-04-17

### Added

- Preexisting load balancer support via AWS `TargetGroupBinding` CRD (`preexisting-lb.yaml`).

## [1.1.0] - 2024-03-21

### Added

- AWS ALB (Application Load Balancer) Ingress support (`service-alb.yaml`).
- Readiness probe support (`tcpSocket`) for frontend deployments.
- Healthcheck configuration for ALB targets.
- `envFrom` support on `initContainers`.

### Changed

- **Breaking:** NLB service now only renders when `loadBalancer.type: network` is set explicitly. Previously any deployment with `loadBalancer.enabled: true` would receive an NLB service regardless of type. Existing NLB deployments must add `loadBalancer.type: network` to their values.
- **Breaking:** The `path` helper in `_common_block.tpl` changed from detecting `type: rails` to detecting whether a `path` value contains `apps`. Services that previously relied on the rails path format must set `path` explicitly.
- ALB backend service uses `NodePort` type.
- `service-lb.yaml` renamed to `service-nlb.yaml`.

### Fixed

- `initContainer` and migrations job `args` corrected to proper YAML list format (were previously rendered as a raw value).
- Guard conditions added to cronjob and migrations templates to prevent errors when those values keys are absent entirely.

## [1.0.995] - 2024-01-23

### Fixed

- Iterative fixes to load balancer and service templates.

## [1.0.994] - 2024-01-17

### Fixed

- Iterative fixes to load balancer and service templates.

## [1.0.993] - 2024-01-04

### Fixed

- Iterative fixes to load balancer and service templates.

## [1.0.992] - 2024-01-04

### Fixed

- Iterative fixes to load balancer and service templates.

## [1.0.991] - 2024-01-04

### Fixed

- Iterative fixes to load balancer and service templates.

## [1.0.99] - 2024-01-04

### Fixed

- Iterative fixes to load balancer and service templates.

## [1.0.98] - 2023-12-20

### Fixed

- ALB routing and annotation fixes.

## [1.0.97] - 2023-12-19

### Fixed

- ALB routing and annotation fixes.

## [1.0.96] - 2023-12-19

### Fixed

- ALB routing and annotation fixes.

## [1.0.95] - 2023-12-19

### Fixed

- ALB routing and annotation fixes.

## [1.0.94] - 2023-12-18

### Fixed

- ALB routing and annotation fixes.

## [1.0.93] - 2023-12-18

### Fixed

- ALB routing and annotation fixes.

## [1.0.92] - 2023-12-18

### Fixed

- ALB routing and annotation fixes.

## [1.0.91] - 2023-12-18

### Fixed

- ALB routing and annotation fixes.

## [1.0.90] - 2023-10-19

### Changed

- IngressRoute rule updated to use unique name per namespace.

## [1.0.89] - 2023-10-19

### Fixed

- Iterative template fixes.

## [1.0.88] - 2023-09-25

### Fixed

- Conditional logic for `loadBalancer` key made more permissive.

## [1.0.87] - 2023-09-25

### Fixed

- Conditional logic for `loadBalancer` key made more permissive.

## [1.0.86] - 2023-09-14

### Fixed

- Iterative template fixes.

## [1.0.85] - 2023-09-11

### Fixed

- Iterative template fixes.

## [1.0.83] - 2023-08-30

### Fixed

- Iterative template fixes.

## [1.0.82] - 2023-08-30

### Fixed

- Iterative template fixes.

## [1.0.81] - 2023-08-30

### Fixed

- Iterative template fixes.

## [1.0.80] - 2023-08-25

### Fixed

- Iterative template fixes.

## [1.0.79] - 2023-08-25

### Fixed

- Iterative template fixes.

## [1.0.77] - 2023-08-24

### Fixed

- Iterative fixes to Traefik service and IngressRoute templates.

## [1.0.76] - 2023-08-24

### Fixed

- Iterative fixes to Traefik service and IngressRoute templates.

## [1.0.75] - 2023-08-24

### Fixed

- Iterative fixes to Traefik service and IngressRoute templates.

## [1.0.74] - 2023-08-24

### Fixed

- Iterative fixes to Traefik service and IngressRoute templates.

## [1.0.73] - 2023-08-24

### Fixed

- Iterative fixes to Traefik service and IngressRoute templates.

## [1.0.72] - 2023-08-24

### Fixed

- Iterative fixes to Traefik service and IngressRoute templates.

## [1.0.71] - 2023-08-23

### Fixed

- Iterative fixes to Traefik service and IngressRoute templates.

## [1.0.70] - 2023-08-23

### Fixed

- Iterative fixes to Traefik service and IngressRoute templates.

## [1.0.69] - 2023-08-23

### Fixed

- Iterative fixes to Traefik service and IngressRoute templates.

## [1.0.68] - 2023-08-22

### Fixed

- Iterative fixes to Traefik service and IngressRoute templates.

## [1.0.67] - 2023-08-22

### Fixed

- Iterative fixes to Traefik service and IngressRoute templates.

## [1.0.66] - 2023-08-22

### Fixed

- Iterative fixes to Traefik service and IngressRoute templates.

## [1.0.65] - 2023-08-22

### Fixed

- Iterative fixes to Traefik service and IngressRoute templates.

## [1.0.64] - 2023-08-21

### Fixed

- Iterative fixes to Traefik service and IngressRoute templates.

## [1.0.63] - 2023-08-21

### Fixed

- Iterative fixes to Traefik service and IngressRoute templates.

## [1.0.62] - 2023-08-21

### Fixed

- Iterative fixes to Traefik service and IngressRoute templates.

## [1.0.61] - 2023-08-21

### Added

- AWS NLB (Network Load Balancer) support (`service-nlb.yaml`) with SSL certificate binding via `loadBalancer.sslCertArn`.

## [1.0.60] - 2023-08-21

### Fixed

- Iterative fixes to service and routing templates.

## [1.0.59] - 2023-08-20

### Fixed

- Iterative fixes to service and routing templates.

## [1.0.57] - 2023-08-20

### Fixed

- Iterative fixes to service and routing templates.

## [1.0.55] - 2023-08-20

### Fixed

- Iterative fixes to service and routing templates.

## [1.0.54] - 2023-08-20

### Fixed

- Iterative fixes to service and routing templates.

## [1.0.53] - 2023-08-20

### Fixed

- Iterative fixes to service and routing templates.

## [1.0.52] - 2023-08-20

### Fixed

- Iterative fixes to service and routing templates.

## [1.0.51] - 2023-08-20

### Fixed

- Iterative fixes to service and routing templates.

## [1.0.50] - 2023-08-20

### Fixed

- Iterative fixes to service and routing templates.

## [1.0.49] - 2023-08-20

### Fixed

- Iterative fixes to service and routing templates.

## [1.0.48] - 2023-08-20

### Fixed

- Iterative fixes to service and routing templates.

## [1.0.47] - 2023-08-20

### Fixed

- Iterative fixes to service and routing templates.

## [1.0.46] - 2023-08-20

### Fixed

- Iterative fixes to service and routing templates.

## [1.0.45] - 2023-08-20

### Fixed

- Iterative fixes to service and routing templates.

## [1.0.44] - 2023-08-20

### Fixed

- Iterative fixes to service and routing templates.

## [1.0.43] - 2023-08-20

### Added

- ALB Ingress support begun (`service-alb.yaml`).

## [1.0.42] - 2023-08-18

### Fixed

- Iterative template fixes.

## [1.0.40] - 2023-08-17

### Fixed

- Iterative template fixes.

## [1.0.39] - 2023-08-17

### Fixed

- Iterative template fixes.

## [1.0.38] - 2023-08-17

### Fixed

- Iterative template fixes.

## [1.0.37] - 2023-08-17

### Fixed

- Iterative template fixes.

## [1.0.36] - 2023-08-17

### Added

- Conditional load balancer support — NLB and IngressRoute templates now only render when `loadBalancer.enabled: true`, allowing Traefik and AWS load balancer configurations to coexist in the same chart.

## [1.0.35] - 2023-08-16

### Fixed

- Iterative fixes to migrations job and init container templates.

## [1.0.34] - 2023-08-16

### Fixed

- Iterative fixes to migrations job and init container templates.

## [1.0.33] - 2023-08-15

### Fixed

- Iterative fixes to migrations job and init container templates.

## [1.0.32] - 2023-08-15

### Fixed

- Iterative fixes to migrations job and init container templates.

## [1.0.31] - 2023-08-15

### Fixed

- Iterative fixes to migrations job and init container templates.

## [1.0.30] - 2023-08-14

### Added

- Migrations job (`migrations-job.yaml`) for running database migrations as a Kubernetes `Job` with TTL cleanup and configurable backoff.
- Init container support for frontend deployments.
- `args` support for migrations job and init containers.

## [1.0.29] - 2023-08-14

### Fixed

- Iterative fixes to CronJob template.

## [1.0.28] - 2023-08-14

### Fixed

- Iterative fixes to CronJob template.

## [1.0.27] - 2023-08-14

### Added

- CronJob template (`cronjob.yaml`) with `schedule`, `timezone`, `command`, `args`, and `envFrom` support.

## [1.0.26] - 2023-08-14

### Fixed

- Iterative fixes to volume and deployment templates.

## [1.0.25] - 2023-08-14

### Fixed

- Iterative fixes to volume and deployment templates.

## [1.0.24] - 2023-08-14

### Fixed

- Iterative fixes to volume and deployment templates.

## [1.0.23] - 2023-08-11

### Fixed

- Iterative fixes to IngressRoute and frontend deployment templates.

## [1.0.22] - 2023-08-11

### Fixed

- Iterative fixes to IngressRoute and frontend deployment templates.

## [1.0.21] - 2023-08-11

### Fixed

- Iterative fixes to IngressRoute and frontend deployment templates.

## [1.0.20] - 2023-08-11

### Added

- `clientIP` routing option for Traefik IngressRoute as an alternative to host-based matching.
- Volume mount support for secrets and persistent volumes on frontend deployment.
- Datadog environment variables (`DD_ENV`, `DD_SERVICE`, `DD_VERSION`, `DD_APPSEC_ENABLED`, `DD_PROFILING_ENABLED`) injected via downward API, replacing the Datadog agent sidecar.
- `envFrom`, `command`, and `args` support on frontend and worker deployments.
- Top-level `project` and `environment` values used for Datadog tagging.

### Changed

- **Breaking:** Image is now specified as a single `image` field (e.g. `image: repo/name:tag`) on each frontend and worker item. The previous separate `repository` and `tag` fields are no longer supported.
- **Breaking:** Datadog agent sidecar removed. Datadog instrumentation now relies on the Datadog admission controller and unified service tagging labels.
- **Breaking:** Traefik `IngressRoute` namespace hardcoded to `traefik`. Previously used the release namespace.
- **Breaking:** `IngressRoute` name changed from `.Release.Name` to `<namespace>-<name>`. Existing IngressRoute resources will be replaced on upgrade.

## [1.0.19] - 2023-08-11

### Fixed

- Iterative fixes to Traefik templates.

## [1.0.18] - 2023-08-11

### Fixed

- Iterative fixes to Traefik templates.

## [1.0.17] - 2023-08-11

### Fixed

- Iterative fixes to Traefik templates.

## [1.0.16] - 2023-08-11

### Fixed

- Iterative fixes to Traefik templates.

## [1.0.15] - 2023-08-11

### Fixed

- Iterative fixes to Traefik templates.

## [1.0.14] - 2023-08-11

### Fixed

- Iterative fixes to Traefik templates.

## [1.0.13] - 2023-08-11

### Fixed

- Iterative fixes to Traefik templates.

## [1.0.12] - 2023-08-11

### Added

- Memcached and Redis as optional Bitnami subchart dependencies, enabled via `memcached.enabled` and `redis.enabled`.

## [1.0.11] - 2023-08-10

### Fixed

- Iterative fixes to deployment and service templates.

## [1.0.10] - 2023-08-10

### Fixed

- Iterative fixes to deployment and service templates.

## [1.0.9] - 2023-08-10

### Fixed

- Iterative fixes to deployment and service templates.

## [1.0.8] - 2023-08-10

### Fixed

- Iterative fixes to deployment and service templates.

## [1.0.7] - 2023-08-09

### Added

- Flux `ImagePolicy` and `ImageUpdateAutomation` templates for automated image tag updates.
- `imagepolicy.pattern` is now required on each frontend and worker item for the ImagePolicy resource to render correctly.

## [1.0.6] - 2023-08-08

### Fixed

- Iterative fixes to frontend deployment template.

## [1.0.5] - 2023-08-08

### Fixed

- Iterative fixes to frontend deployment template.

## [1.0.4] - 2023-08-08

### Added

- Key injection support via volume-mounted secrets.

## [1.0.3] - 2023-08-08

### Fixed

- Iterative fixes to initial templates.

## [1.0.2] - 2023-08-08

### Added

- Initial chart release with frontend deployment, worker deployment, Traefik `IngressRoute`, `TraefikService`, and `Service` templates.
- Datadog unified service tagging on deployments via a Datadog agent sidecar.
- Array-based `frontend` and `worker` values schema supporting multiple deployments per release.
- Image specified as separate `repository` and `tag` fields on each frontend and worker item.

---

[Unreleased]: https://github.com/tithely/helm-charts/compare/generic-service-2.0.0-alpha...HEAD
[2.0.0-alpha]: https://github.com/tithely/helm-charts/compare/generic-service-1.1.6-delta...generic-service-2.0.0-alpha
[1.1.6-delta]: https://github.com/tithely/helm-charts/compare/generic-service-1.1.6-charlie...generic-service-1.1.6-delta
[1.1.6-charlie]: https://github.com/tithely/helm-charts/compare/generic-service-1.1.6-beta...generic-service-1.1.6-charlie
[1.1.6-beta]: https://github.com/tithely/helm-charts/compare/generic-service-1.1.6-alpha...generic-service-1.1.6-beta
[1.1.6-alpha]: https://github.com/tithely/helm-charts/compare/generic-service-1.1.5...generic-service-1.1.6-alpha
[1.1.5]: https://github.com/tithely/helm-charts/compare/generic-service-1.1.4...generic-service-1.1.5
[1.1.4]: https://github.com/tithely/helm-charts/compare/generic-service-1.1.3...generic-service-1.1.4
[1.1.3]: https://github.com/tithely/helm-charts/compare/generic-service-1.1.2...generic-service-1.1.3
[1.1.2]: https://github.com/tithely/helm-charts/compare/generic-service-1.1.1...generic-service-1.1.2
[1.1.1]: https://github.com/tithely/helm-charts/compare/generic-service-1.1.0...generic-service-1.1.1
[1.1.0]: https://github.com/tithely/helm-charts/compare/generic-service-1.0.995...generic-service-1.1.0
[1.0.995]: https://github.com/tithely/helm-charts/compare/generic-service-1.0.994...generic-service-1.0.995
[1.0.994]: https://github.com/tithely/helm-charts/compare/generic-service-1.0.993...generic-service-1.0.994
[1.0.993]: https://github.com/tithely/helm-charts/compare/generic-service-1.0.992...generic-service-1.0.993
[1.0.992]: https://github.com/tithely/helm-charts/compare/generic-service-1.0.991...generic-service-1.0.992
[1.0.991]: https://github.com/tithely/helm-charts/compare/generic-service-1.0.99...generic-service-1.0.991
[1.0.99]: https://github.com/tithely/helm-charts/compare/generic-service-1.0.98...generic-service-1.0.99
[1.0.98]: https://github.com/tithely/helm-charts/compare/generic-service-1.0.97...generic-service-1.0.98
[1.0.97]: https://github.com/tithely/helm-charts/compare/generic-service-1.0.96...generic-service-1.0.97
[1.0.96]: https://github.com/tithely/helm-charts/compare/generic-service-1.0.95...generic-service-1.0.96
[1.0.95]: https://github.com/tithely/helm-charts/compare/generic-service-1.0.94...generic-service-1.0.95
[1.0.94]: https://github.com/tithely/helm-charts/compare/generic-service-1.0.93...generic-service-1.0.94
[1.0.93]: https://github.com/tithely/helm-charts/compare/generic-service-1.0.92...generic-service-1.0.93
[1.0.92]: https://github.com/tithely/helm-charts/compare/generic-service-1.0.91...generic-service-1.0.92
[1.0.91]: https://github.com/tithely/helm-charts/compare/generic-service-1.0.90...generic-service-1.0.91
[1.0.90]: https://github.com/tithely/helm-charts/compare/generic-service-1.0.89...generic-service-1.0.90
[1.0.89]: https://github.com/tithely/helm-charts/compare/generic-service-1.0.88...generic-service-1.0.89
[1.0.88]: https://github.com/tithely/helm-charts/compare/generic-service-1.0.87...generic-service-1.0.88
[1.0.87]: https://github.com/tithely/helm-charts/compare/generic-service-1.0.86...generic-service-1.0.87
[1.0.86]: https://github.com/tithely/helm-charts/compare/generic-service-1.0.85...generic-service-1.0.86
[1.0.85]: https://github.com/tithely/helm-charts/compare/generic-service-1.0.83...generic-service-1.0.85
[1.0.83]: https://github.com/tithely/helm-charts/compare/generic-service-1.0.82...generic-service-1.0.83
[1.0.82]: https://github.com/tithely/helm-charts/compare/generic-service-1.0.81...generic-service-1.0.82
[1.0.81]: https://github.com/tithely/helm-charts/compare/generic-service-1.0.80...generic-service-1.0.81
[1.0.80]: https://github.com/tithely/helm-charts/compare/generic-service-1.0.79...generic-service-1.0.80
[1.0.79]: https://github.com/tithely/helm-charts/compare/generic-service-1.0.77...generic-service-1.0.79
[1.0.77]: https://github.com/tithely/helm-charts/compare/generic-service-1.0.76...generic-service-1.0.77
[1.0.76]: https://github.com/tithely/helm-charts/compare/generic-service-1.0.75...generic-service-1.0.76
[1.0.75]: https://github.com/tithely/helm-charts/compare/generic-service-1.0.74...generic-service-1.0.75
[1.0.74]: https://github.com/tithely/helm-charts/compare/generic-service-1.0.73...generic-service-1.0.74
[1.0.73]: https://github.com/tithely/helm-charts/compare/generic-service-1.0.72...generic-service-1.0.73
[1.0.72]: https://github.com/tithely/helm-charts/compare/generic-service-1.0.71...generic-service-1.0.72
[1.0.71]: https://github.com/tithely/helm-charts/compare/generic-service-1.0.70...generic-service-1.0.71
[1.0.70]: https://github.com/tithely/helm-charts/compare/generic-service-1.0.69...generic-service-1.0.70
[1.0.69]: https://github.com/tithely/helm-charts/compare/generic-service-1.0.68...generic-service-1.0.69
[1.0.68]: https://github.com/tithely/helm-charts/compare/generic-service-1.0.67...generic-service-1.0.68
[1.0.67]: https://github.com/tithely/helm-charts/compare/generic-service-1.0.66...generic-service-1.0.67
[1.0.66]: https://github.com/tithely/helm-charts/compare/generic-service-1.0.65...generic-service-1.0.66
[1.0.65]: https://github.com/tithely/helm-charts/compare/generic-service-1.0.64...generic-service-1.0.65
[1.0.64]: https://github.com/tithely/helm-charts/compare/generic-service-1.0.63...generic-service-1.0.64
[1.0.63]: https://github.com/tithely/helm-charts/compare/generic-service-1.0.62...generic-service-1.0.63
[1.0.62]: https://github.com/tithely/helm-charts/compare/generic-service-1.0.61...generic-service-1.0.62
[1.0.61]: https://github.com/tithely/helm-charts/compare/generic-service-1.0.60...generic-service-1.0.61
[1.0.60]: https://github.com/tithely/helm-charts/compare/generic-service-1.0.59...generic-service-1.0.60
[1.0.59]: https://github.com/tithely/helm-charts/compare/generic-service-1.0.57...generic-service-1.0.59
[1.0.57]: https://github.com/tithely/helm-charts/compare/generic-service-1.0.55...generic-service-1.0.57
[1.0.55]: https://github.com/tithely/helm-charts/compare/generic-service-1.0.54...generic-service-1.0.55
[1.0.54]: https://github.com/tithely/helm-charts/compare/generic-service-1.0.53...generic-service-1.0.54
[1.0.53]: https://github.com/tithely/helm-charts/compare/generic-service-1.0.52...generic-service-1.0.53
[1.0.52]: https://github.com/tithely/helm-charts/compare/generic-service-1.0.51...generic-service-1.0.52
[1.0.51]: https://github.com/tithely/helm-charts/compare/generic-service-1.0.50...generic-service-1.0.51
[1.0.50]: https://github.com/tithely/helm-charts/compare/generic-service-1.0.49...generic-service-1.0.50
[1.0.49]: https://github.com/tithely/helm-charts/compare/generic-service-1.0.48...generic-service-1.0.49
[1.0.48]: https://github.com/tithely/helm-charts/compare/generic-service-1.0.47...generic-service-1.0.48
[1.0.47]: https://github.com/tithely/helm-charts/compare/generic-service-1.0.46...generic-service-1.0.47
[1.0.46]: https://github.com/tithely/helm-charts/compare/generic-service-1.0.45...generic-service-1.0.46
[1.0.45]: https://github.com/tithely/helm-charts/compare/generic-service-1.0.44...generic-service-1.0.45
[1.0.44]: https://github.com/tithely/helm-charts/compare/generic-service-1.0.43...generic-service-1.0.44
[1.0.43]: https://github.com/tithely/helm-charts/compare/generic-service-1.0.42...generic-service-1.0.43
[1.0.42]: https://github.com/tithely/helm-charts/compare/generic-service-1.0.40...generic-service-1.0.42
[1.0.40]: https://github.com/tithely/helm-charts/compare/generic-service-1.0.39...generic-service-1.0.40
[1.0.39]: https://github.com/tithely/helm-charts/compare/generic-service-1.0.38...generic-service-1.0.39
[1.0.38]: https://github.com/tithely/helm-charts/compare/generic-service-1.0.37...generic-service-1.0.38
[1.0.37]: https://github.com/tithely/helm-charts/compare/generic-service-1.0.36...generic-service-1.0.37
[1.0.36]: https://github.com/tithely/helm-charts/compare/generic-service-1.0.35...generic-service-1.0.36
[1.0.35]: https://github.com/tithely/helm-charts/compare/generic-service-1.0.34...generic-service-1.0.35
[1.0.34]: https://github.com/tithely/helm-charts/compare/generic-service-1.0.33...generic-service-1.0.34
[1.0.33]: https://github.com/tithely/helm-charts/compare/generic-service-1.0.32...generic-service-1.0.33
[1.0.32]: https://github.com/tithely/helm-charts/compare/generic-service-1.0.31...generic-service-1.0.32
[1.0.31]: https://github.com/tithely/helm-charts/compare/generic-service-1.0.30...generic-service-1.0.31
[1.0.30]: https://github.com/tithely/helm-charts/compare/generic-service-1.0.29...generic-service-1.0.30
[1.0.29]: https://github.com/tithely/helm-charts/compare/generic-service-1.0.28...generic-service-1.0.29
[1.0.28]: https://github.com/tithely/helm-charts/compare/generic-service-1.0.27...generic-service-1.0.28
[1.0.27]: https://github.com/tithely/helm-charts/compare/generic-service-1.0.26...generic-service-1.0.27
[1.0.26]: https://github.com/tithely/helm-charts/compare/generic-service-1.0.25...generic-service-1.0.26
[1.0.25]: https://github.com/tithely/helm-charts/compare/generic-service-1.0.24...generic-service-1.0.25
[1.0.24]: https://github.com/tithely/helm-charts/compare/generic-service-1.0.23...generic-service-1.0.24
[1.0.23]: https://github.com/tithely/helm-charts/compare/generic-service-1.0.22...generic-service-1.0.23
[1.0.22]: https://github.com/tithely/helm-charts/compare/generic-service-1.0.21...generic-service-1.0.22
[1.0.21]: https://github.com/tithely/helm-charts/compare/generic-service-1.0.20...generic-service-1.0.21
[1.0.20]: https://github.com/tithely/helm-charts/compare/generic-service-1.0.19...generic-service-1.0.20
[1.0.19]: https://github.com/tithely/helm-charts/compare/generic-service-1.0.18...generic-service-1.0.19
[1.0.18]: https://github.com/tithely/helm-charts/compare/generic-service-1.0.17...generic-service-1.0.18
[1.0.17]: https://github.com/tithely/helm-charts/compare/generic-service-1.0.16...generic-service-1.0.17
[1.0.16]: https://github.com/tithely/helm-charts/compare/generic-service-1.0.15...generic-service-1.0.16
[1.0.15]: https://github.com/tithely/helm-charts/compare/generic-service-1.0.14...generic-service-1.0.15
[1.0.14]: https://github.com/tithely/helm-charts/compare/generic-service-1.0.13...generic-service-1.0.14
[1.0.13]: https://github.com/tithely/helm-charts/compare/generic-service-1.0.12...generic-service-1.0.13
[1.0.12]: https://github.com/tithely/helm-charts/compare/generic-service-1.0.11...generic-service-1.0.12
[1.0.11]: https://github.com/tithely/helm-charts/compare/generic-service-1.0.10...generic-service-1.0.11
[1.0.10]: https://github.com/tithely/helm-charts/compare/generic-service-1.0.9...generic-service-1.0.10
[1.0.9]: https://github.com/tithely/helm-charts/compare/generic-service-1.0.8...generic-service-1.0.9
[1.0.8]: https://github.com/tithely/helm-charts/compare/generic-service-1.0.7...generic-service-1.0.8
[1.0.7]: https://github.com/tithely/helm-charts/compare/generic-service-1.0.6...generic-service-1.0.7
[1.0.6]: https://github.com/tithely/helm-charts/compare/generic-service-1.0.5...generic-service-1.0.6
[1.0.5]: https://github.com/tithely/helm-charts/compare/generic-service-1.0.4...generic-service-1.0.5
[1.0.4]: https://github.com/tithely/helm-charts/compare/generic-service-1.0.3...generic-service-1.0.4
[1.0.3]: https://github.com/tithely/helm-charts/compare/generic-service-1.0.2...generic-service-1.0.3
[1.0.2]: https://github.com/tithely/helm-charts/releases/tag/generic-service-1.0.2
