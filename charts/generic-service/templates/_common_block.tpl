{{- define "frontendLabels" }}
app.kubernetes.io/name: frontend
app.kubernetes.io/component: web
app.kubernetes.io/part-of: {{ $.Release.Name | quote }}
{{- end }}

{{- define "serviceLabels" }}
app.kubernetes.io/name: frontend
app.kubernetes.io/component: service
app.kubernetes.io/part-of: {{ $.Release.Name | quote }}
{{- end }}

{{- define "workerLabels" }}
app.kubernetes.io/name: worker
app.kubernetes.io/component: worker
app.kubernetes.io/part-of: {{ $.Release.Name | quote }}
{{- end }}

{{- define "path" }}
    path: {{ .Values.project | replace "-" "/" }}/{{ .Values.environment }}
{{- end }}
