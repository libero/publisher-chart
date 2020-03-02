{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "publisher.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "publisher.labels" -}}
helm.sh/chart: {{ include "publisher.chart" . }}
{{ include "publisher.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "publisher.selectorLabels" -}}
app.kubernetes.io/name: {{ .Chart.Name }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/*
Default article store app envvars
*/}}
{{- define "publisher.articleStoreAppEnv" -}}
{{- if .Values.postgresql.secretName -}}
- name: DATABASE_NAME
  valueFrom:
    secretKeyRef:
      name: "{{ .Values.postgresql.secretName }}"
      key: postgresql-database
- name: DATABASE_USER
  valueFrom:
    secretKeyRef:
      name: "{{ .Values.postgresql.secretName }}"
      key: postgresql-username
- name: DATABASE_PASSWORD
  valueFrom:
    secretKeyRef:
      name: "{{ .Values.postgresql.secretName }}"
      key: postgresql-password
- name: DATABASE_HOST
  valueFrom:
    secretKeyRef:
      name: "{{ .Values.postgresql.secretName }}"
      key: postgresql-host
- name: DATABASE_PORT
  valueFrom:
    secretKeyRef:
      name: "{{ .Values.postgresql.secretName }}"
      key: postgresql-port
{{- else -}}
- name: DATABASE_NAME
  value: "{{ .Values.postgresql.postgresqlDatabase }}"
- name: DATABASE_USER
  value: "{{ .Values.postgresql.postgresqlUsername }}"
- name: DATABASE_PASSWORD
  valueFrom:
    secretKeyRef:
      name: "{{ .Release.Name }}-article-store-postgresql"
      key: postgresql-password
- name: DATABASE_HOST
  value: "{{ .Release.Name }}-article-store-postgresql"
- name: DATABASE_PORT
  value: "{{ .Values.postgresql.service.port }}"
{{- end -}}
{{- end -}}
