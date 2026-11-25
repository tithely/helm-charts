# generic-helm3

General-purpose chart for one workload: a Deployment, plus optional Service, ConfigMap, ServiceAccount, HPA, PDB, NetworkPolicy, Jobs and any extra manifests.

Published to ECR as an OCI chart by `.github/workflows/release-oci.yaml` when `version` in `Chart.yaml` changes on `main`:

```
oci://700585553097.dkr.ecr.us-east-1.amazonaws.com/helm-charts/generic-helm3
```

## Usage with Argo CD

One source per component, values inline. A multi-source Application can share a values file (for example an image tag written by Image Updater) through `$values`:

```yaml
sources:
  - repoURL: git@github.com:tithely/devops-cicd.git
    targetRevision: main
    ref: values
  - repoURL: oci://700585553097.dkr.ecr.us-east-1.amazonaws.com/helm-charts/generic-helm3
    targetRevision: 0.4.0
    path: .
    helm:
      releaseName: myapp-qa-api
      valueFiles: [$values/argocd/environments/qa/myapp-image.yaml]
      valuesObject:
        nameOverride: api
        replicaCount: 2
        envFrom: [{ secretRef: { name: myapp-env } }]
        datadog: { enabled: true, env: qa, service: myapp, logSource: python }
```

## Main values

| Key | Default | Description |
|---|---|---|
| `image.repository` / `image.tag` | | Image. `tag` falls back to `appVersion` |
| `nameOverride` | `""` | Short name, used in the `app.kubernetes.io/name` label and the full name `<release>-<name>` |
| `containerName` | full name | Main container name |
| `namespace` | release namespace | Namespace for the chart's objects |
| `command` / `args` / `env` / `envFrom` | unset | Main container |
| `resources` | `{}` | Requests and limits |
| `podLabels` / `podAnnotations` | `{}` | Extra pod metadata |
| `service.enabled` | `true` | Render the chart's Service. Set `false` when pods are reached through an existing Service |
| `service.containerPort` | `8080` | Container port `http`. Set `null` for no port |
| `datadog.enabled` | `false` | Datadog tags, admission label, `DD_*` env and log annotation. Needs `datadog.env` and `datadog.service` |
| `datadog.logSource` | `""` | Log source for `ad.datadoghq.com/<container>.logs` |
| `extraObjects` | `[]` | Extra manifests (maps or strings, rendered with `tpl`) |
| `jobs` | unset | Map of Jobs; see `values.yaml` |
| `autoscaling` / `pdb` / `networkPolicy` | disabled | HPA, PodDisruptionBudget, NetworkPolicy |
| `tests.enabled` | `false` | Helm test pod |

See `values.yaml` for the rest and [CHANGELOG.md](CHANGELOG.md) for changes.
