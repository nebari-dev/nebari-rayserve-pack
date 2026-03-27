{{/*
Expand the name of the chart.
*/}}
{{- define "nebari-rayserve.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "nebari-rayserve.fullname" -}}
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
{{- define "nebari-rayserve.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "nebari-rayserve.labels" -}}
helm.sh/chart: {{ include "nebari-rayserve.chart" . }}
{{ include "nebari-rayserve.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "nebari-rayserve.selectorLabels" -}}
app.kubernetes.io/name: {{ include "nebari-rayserve.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Ray head service name - RayService creates a service named <rayservice-name>-head-svc.
*/}}
{{- define "nebari-rayserve.head-service-name" -}}
{{- printf "%s-head-svc" (include "nebari-rayserve.fullname" .) }}
{{- end }}

{{/*
Ray serve service name - RayService creates a service named <rayservice-name>-serve-svc.
*/}}
{{- define "nebari-rayserve.serve-service-name" -}}
{{- printf "%s-serve-svc" (include "nebari-rayserve.fullname" .) }}
{{- end }}
