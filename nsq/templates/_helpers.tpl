{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "nsq.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "nsq.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "nsq.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "nsq.labels.common" -}}
helm.sh/chart: {{ include "nsq.chart" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{- define "nsq.labels" -}}
app.kubernetes.io/name: {{ include "nsq.name" . }}
{{ include "nsq.labels.common" . -}}
{{- end -}}

{{/* -----------------------[ NSQd ]------------------------- */}}

{{- define "nsqd.name" -}}
{{- include "nsq.name" . -}}-nsqd
{{- end -}}

{{- define "nsqd.fullname" -}}
{{- include "nsq.fullname" . -}}-nsqd
{{- end -}}

{{- define "nsqd.labels" -}}
app.kubernetes.io/name: {{ include "nsqd.name" . }}
{{ include "nsq.labels.common" . -}}
{{- end -}}

{{/*
Create NSQd path.
if .Values.nsqd.path is empty, default value "/nsqd-data".
*/}}
{{- define "nsqd.fullpath" -}}
{{- if .Values.nsqd.path -}}
{{- .Values.nsqd.path | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s" "/nsqd-data" -}}
{{- end -}}
{{- end -}}

{{/* -----------------------[ NSQlookupd ]------------------------- */}}

{{- define "nsqlookupd.name" -}}
{{- include "nsq.name" . -}}-nsqlookupd
{{- end -}}

{{- define "nsqlookupd.fullname" -}}
{{- include "nsq.fullname" . -}}-nsqlookupd
{{- end -}}

{{- define "nsqlookupd.labels" -}}
app.kubernetes.io/name: {{ include "nsqlookupd.name" . }}
{{ include "nsq.labels.common" . -}}
{{- end -}}

{{/* -----------------------[ NSQAdmin ]------------------------- */}}

{{- define "nsqadmin.name" -}}
{{- include "nsq.name" . -}}-nsqadmin
{{- end -}}

{{- define "nsqadmin.fullname" -}}
{{- include "nsq.fullname" . -}}-nsqadmin
{{- end -}}

{{- define "nsqadmin.labels" -}}
app.kubernetes.io/name: {{ include "nsqadmin.name" . }}
{{ include "nsq.labels.common" . -}}
{{- end -}}
