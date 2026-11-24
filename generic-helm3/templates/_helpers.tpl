{{/*
Expand the name of the chart.
*/}}
{{- define "generic-helm3.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "generic-helm3.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "generic-helm3.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "generic-helm3.labels" -}}
helm.sh/chart: {{ include "generic-helm3.chart" . }}
{{ include "generic-helm3.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "generic-helm3.selectorLabels" -}}
app.kubernetes.io/name: {{ include "generic-helm3.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "generic-helm3.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "generic-helm3.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{- define "generic-helm3.namespace" -}}
{{- default .Release.Namespace .Values.namespace }}
{{- end }}

{{- define "generic-helm3.containerName" -}}
{{- default (include "generic-helm3.fullname" .) .Values.containerName }}
{{- end }}

{{- define "generic-helm3.datadogVersion" -}}
{{- .Values.image.tag | default .Chart.AppVersion | toString | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "generic-helm3.datadogLabels" -}}
{{- if .Values.datadog.enabled -}}
tags.datadoghq.com/env: {{ required "datadog.env is required when datadog.enabled" .Values.datadog.env | quote }}
tags.datadoghq.com/service: {{ required "datadog.service is required when datadog.enabled" .Values.datadog.service | quote }}
tags.datadoghq.com/version: {{ include "generic-helm3.datadogVersion" . | quote }}
{{- end }}
{{- end }}

{{- define "generic-helm3.datadogEnv" -}}
{{- if .Values.datadog.enabled -}}
- name: DD_ENV
  valueFrom:
    fieldRef:
      fieldPath: metadata.labels['tags.datadoghq.com/env']
- name: DD_SERVICE
  valueFrom:
    fieldRef:
      fieldPath: metadata.labels['tags.datadoghq.com/service']
- name: DD_VERSION
  valueFrom:
    fieldRef:
      fieldPath: metadata.labels['tags.datadoghq.com/version']
- name: DD_APPSEC_ENABLED
  value: {{ .Values.datadog.appsec | toString | quote }}
- name: DD_PROFILING_ENABLED
  value: {{ .Values.datadog.profiling | toString | quote }}
{{- end }}
{{- end }}
