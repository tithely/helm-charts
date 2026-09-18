# Changelog — generic-service (1.1.x maintenance line)

All notable changes to the 1.1.x line of this chart are documented here.

> **Note on version suffixes:** the 1.1.6 series uses Greek-letter suffixes
> (alpha < beta < charlie < delta < echo) as pre-release stand-ins, matching the
> convention on the main line. `1.1.6-echo` is the next pre-release after
> `1.1.6-delta`.
>
> This file is new to the 1.1.x line (the earlier `1.1.6-*` tags predate the
> chart's CHANGELOG, which was added on the 2.x/main line).

## [1.1.6-echo] - 2026-09-18

### Fixed

- **ImageUpdateAutomation commit-message template no longer breaks on newer Flux
  controllers.** The template hardcoded `{{ range .Changed.Images }}…`, which
  throws on controllers using the `ResultV2` template data
  ("can't evaluate field Images in type update.ResultV2"). When that happens the
  automation renders no commit, never pushes the image-tag update, and the
  environment **silently stops auto-deploying** (running pods stay healthy, so
  there is no outage and no obvious signal). Replaced with a static, Helm-rendered
  message (`{{ .Release.Name }}: automated image update by Flux`) that cannot break
  across controller versions. Rendering the chart with real environment values
  shows this is the only change to the output — no workload manifests are affected.
