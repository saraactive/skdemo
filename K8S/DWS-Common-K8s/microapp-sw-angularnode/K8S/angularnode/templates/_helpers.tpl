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
{{- define "microapp.envconfigmap" -}}
{{- printf "digiwas-sw-env-%s"  .Values.appGroup | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- define "microapp.configmap" -}}
{{- printf "nodeproxy-configmap-%s"  .Values.appGroup | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- define "microapp.appid-bind" -}}
{{- printf "binding-%s" .Values.bindservice.appid| trunc 63 | trimSuffix "-" -}}
{{- end -}}
