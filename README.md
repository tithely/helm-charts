# helm-charts

Helm charts for Tithely Kubernetes deployments.

Charts are published automatically to the GitHub Pages Helm repository on every merge to `main` via [chart-releaser](https://github.com/helm/chart-releaser-action).

## Charts

| Chart | Version | Description | Docs |
|-------|---------|-------------|------|
| [argocd-app](charts/argocd-apps/) | 1.0.1 | Deployments managed by ArgoCD | [README](charts/argocd-apps/README.md) · [CHANGELOG](charts/argocd-apps/CHANGELOG.md) |
| [generic-service](charts/generic-service/) | 2.0.0-alpha | General-purpose service deployments | [README](charts/generic-service/README.md) · [CHANGELOG](charts/generic-service/CHANGELOG.md) · [CONTRIBUTING](charts/generic-service/CONTRIBUTING.md) |

## Development

[pre-commit](https://pre-commit.com) is used to enforce consistency. Install it and set up the hooks:

```bash
pip install pre-commit OR brew install pre-commit
pre-commit install
```


The following hooks run on every commit:

| Hook | Purpose |
|------|---------|
| `helm-docs` | Regenerates `README.md` for each chart from `Chart.yaml` and `Values.yaml` |
| `detect-secrets` | Prevents accidental secret commits |
| `checkov` | Static analysis for Kubernetes misconfigurations |
| `end-of-file-fixer` | Ensures files end with a newline |
| `trailing-whitespace` | Removes trailing whitespace |

After changing a chart's `Values.yaml` or `Chart.yaml`, run `pre-commit run helm-docs` to regenerate the chart README before committing.
