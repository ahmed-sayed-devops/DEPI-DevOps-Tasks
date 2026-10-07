{{- define "webapp.fullname" -}}
{{ .Release.Name }}-{{ .Chart.Name }}
{{- end }}

{{- define "webapp.labels" -}}
app: {{ include "webapp.fullname" . }}
{{- end }}
