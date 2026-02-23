# Contributing to generic-service

## Versioning

This chart follows [Semantic Versioning](https://semver.org/):

- **Patch** (`1.1.x`): Bug fixes and changes that do not affect the rendered output for existing values.
- **Minor** (`1.x.0`): New optional fields added to the values schema. Existing deployments are unaffected when upgrading.
- **Major** (`x.0.0`): Breaking changes to the values schema. Deployments require values file changes before upgrading.

## Release Process

### 1. Development

Create a feature branch and bump `Chart.yaml` to the next version with an `-rc.N` suffix:

```yaml
version: 2.1.0-rc.1
```

When the branch is merged to `main`, `chart-releaser` automatically publishes it as a GitHub pre-release. The chart is available in the Helm repo at exactly that version string.

If changes are needed after the first RC, increment the suffix (`-rc.2`, `-rc.3`, etc.) on subsequent PRs.

### 2. QA Validation

Once an RC is published, update one or more representative services in the GitOps repo to pin the pre-release version explicitly in their `HelmRelease`:

```yaml
spec:
  chart:
    spec:
      chart: generic-service
      version: 2.1.0-rc.1
```

Flux will pick up the pre-release and deploy it. Validate in QA before proceeding.

Renovate will **not** automatically propose RC versions to other services because it ignores pre-release versions by default. Only services you explicitly update will receive the RC.

### 3. Promoting to Stable

Once QA passes, open a PR that only changes `Chart.yaml`:

```yaml
version: 2.1.0
```

Merging this PR publishes the stable release. Renovate will then open upgrade PRs for all services still on the previous stable version.

## Updating the Changelog

Every PR that changes chart behavior must update `CHANGELOG.md`. The format follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).

### During development (RC phase)

Add your changes under `## [Unreleased]`. Use the appropriate subsection:

- **Added** — new features or values fields
- **Changed** — changes to existing behavior, including breaking changes (prefix breaking changes with `**Breaking:**`)
- **Fixed** — bug fixes
- **Removed** — removed features or values fields

Example:

```markdown
## [Unreleased]

### Added

- `readinessProbe.httpGet.path` support on worker deployments.

### Changed

- **Breaking:** `resources.cpu` is now an integer (millicores); remove the `m` suffix from existing values.
```

### When promoting to stable

Move all entries from `## [Unreleased]` into a new versioned section and add the release date:

```markdown
## [2.1.0] - 2026-02-20

### Added

- `readinessProbe.httpGet.path` support on worker deployments.
```

Also add a comparison link at the bottom of the file:

```markdown
[2.1.0]: https://github.com/tithely/helm-charts/compare/generic-service-2.0.0-alpha...generic-service-2.1.0
```

And update the `[Unreleased]` link to point to the new tag:

```markdown
[Unreleased]: https://github.com/tithely/helm-charts/compare/generic-service-2.1.0...HEAD
```

Leave `## [Unreleased]` in place (empty) for the next development cycle.

## What Does Not Need an RC

Patches that only fix bugs in template rendering and do not change the values schema can be merged directly as a patch version bump (e.g., `2.0.0` → `2.0.1`) without going through the RC process. Use judgment — if the fix affects any live service, an RC is still worthwhile.
