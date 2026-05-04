{{- define "quarter.patternName" -}}
{{- default "quarter" .Values.global.pattern -}}
{{- end -}}

{{- define "quarter.namespaceGitops" -}}
{{- default "openshift-gitops" .Values.global.gitops.namespace -}}
{{- end -}}

{{- define "quarter.projectGitops" -}}
{{- default "hub" .Values.global.gitops.project -}}
{{- end -}}
