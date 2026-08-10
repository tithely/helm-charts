# Claude Code Instructions

**First action in any session:** you should already have `AGENTS.md` in
context (the `SessionStart` hook in `.claude/settings.json` loads it). If it
did not fire, **Read `AGENTS.md` now** before responding.

`AGENTS.md` is the single source of truth for AI agents in this repository.

## Non-negotiable

- A chart change ripples to every consumer that pins it (`devops-cicd` via
  Flux, `devops-argocd` via ArgoCD). Scope every change and prefer
  documentation or metadata-only edits unless a chart change is intended.
- After changing any chart's `Values.yaml` or `Chart.yaml`, run
  `pre-commit run helm-docs` to regenerate that chart's `README.md`. Never edit
  a chart `README.md` by hand.
- Follow `charts/generic-service/CONTRIBUTING.md` for versioning and the
  `-rc.N` release process.
