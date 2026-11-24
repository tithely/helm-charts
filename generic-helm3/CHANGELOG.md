# Changelog — generic-helm3

All notable changes to this chart will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.4.0] - 2026-11-24

### Added

- `extraObjects`: extra manifests rendered with the release, as maps or strings, passed through `tpl`. Used to manage or adopt objects the chart has no template for (OnePasswordItem, TargetGroupBinding, an existing Service).
- `datadog` block (`enabled`, `env`, `service`, `logSource`, `appsec`, `profiling`): unified service tags on the Deployment and pods (`version` from `image.tag`), `admission.datadoghq.com/enabled`, the `DD_*` env vars and the `ad.datadoghq.com/<container>.logs` annotation.
- `service.enabled` (default `true`).
- `containerName`, to set the main container's name (defaults to the full name).
- `tests.enabled` (default `false`) gates the Helm test pod.

### Changed

- **Breaking:** `resources` defaults to `{}` instead of a 488Mi request and 2861Mi limit.
- **Breaking:** `podAnnotations` defaults to `{}`; the placeholder annotations are gone.
- `namespace` defaults to the release namespace instead of rendering empty.
- `volumes` and `volumeMounts` default to `[]`. The Deployment renders `env`, `ports`, probes, `resources`, `securityContext`, `volumeMounts` and `volumes` only when set, so the defaults produce a valid Deployment.
- Job pods no longer carry the Deployment's selector labels (they use `app.kubernetes.io/instance`, `app.kubernetes.io/component: job` and `job-name`), so a running Job can't receive the Service's traffic.

### Fixed

- `pdb.maxUnavailable` was rendered as `minAvailable`. The value key was also misspelled (`maxunAvailable`).

## [0.3.1]

Previous unreleased versions; no changelog.
