PATTERN_NAME ?= quarter
CHART_DIR ?= charts/hub/quarter-tenancy
VALUES_GLOBAL ?= values-global.yaml
VALUES_HUB ?= values-hub.yaml
RENDER_DIR ?= .output
RENDER_FILE ?= $(RENDER_DIR)/$(PATTERN_NAME)-hub.yaml
NAMESPACE ?= openshift-gitops

.PHONY: help install render apply uninstall clean lint load-secrets

help:
	@echo "Available targets:"
	@echo "  make install       Render and apply the Tier 0 pattern manifests"
	@echo "  make render        Render manifests to $(RENDER_FILE)"
	@echo "  make apply         Apply previously rendered manifests"
	@echo "  make uninstall     Remove pattern-managed resources from the hub"
	@echo "  make clean         Remove rendered artifacts"
	@echo "  make lint          Validate chart rendering"
	@echo "  make load-secrets  Print secret backend status"

install: render apply

$(RENDER_DIR):
	@mkdir -p "$(RENDER_DIR)"

render: $(RENDER_DIR)
	@helm template "$(PATTERN_NAME)" "$(CHART_DIR)" \
		-f "$(VALUES_GLOBAL)" \
		-f "$(VALUES_HUB)" > "$(RENDER_FILE)"
	@echo "Rendered manifests: $(RENDER_FILE)"

apply:
	@oc apply -f "$(RENDER_FILE)"
	@echo "Applied pattern resources from $(RENDER_FILE)"

uninstall: render
	@oc delete -f "$(RENDER_FILE)" --ignore-not-found=true
	@echo "Removed pattern resources from $(RENDER_FILE)"

clean:
	@rm -rf "$(RENDER_DIR)"
	@echo "Removed render output"

lint:
	@helm lint "$(CHART_DIR)"
	@helm template "$(PATTERN_NAME)" "$(CHART_DIR)" \
		-f "$(VALUES_GLOBAL)" \
		-f "$(VALUES_HUB)" > /dev/null
	@echo "Helm chart lint + render checks passed"

load-secrets:
	@echo "Secret backend: $$(awk '/^[[:space:]]*backend:/ {print $$2; exit}' $(VALUES_GLOBAL) 2>/dev/null || echo 'abstract')"
	@echo "No secret material is committed in this repository."
