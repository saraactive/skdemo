{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "microapp.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "microapp.fullname" -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- printf "%s-%s"  $name .Values.appGroup | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create the specific name for the ocnfiguration
*/}}
{{- define "microapp.configmap" -}}
{{- printf "taskform-configmap-%s"  .Values.appGroup | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- define "microapp.envconfigmap" -}}
{{- printf "taskform-env-%s"  .Values.appGroup | trunc 63 | trimSuffix "-" -}}
{{- end -}}

