# Secret management model

This repository uses an abstraction-first approach so Vault and External Secrets can be adopted without restructuring policy workflows.

## Interface

The logical secret contract lives in `values-global.yaml` under `global.secrets`:

- `backend`: `abstract`, `vault`, or `external-secrets`
- `keycloak.targetSecretName`: secret name consumed by tenancy components
- `keycloak.clientSecretKey`: key name inside the destination Secret

## Adapters

`charts/hub/quarter-tenancy/templates/keycloak-secret-adapters.yaml` provides adapter resources:

- **abstract:** writes only a contract ConfigMap, no secret delivery object
- **vault:** emits a placeholder Secret annotated for Vault-based reconciliation
- **external-secrets:** emits `ExternalSecret` referencing a `SecretStore`/`ClusterSecretStore`

Adapters are disabled by default to keep sandbox adoption low-risk while secret backend choice is finalized.

## Transition guidance

1. Keep `backend: abstract` while validating policy and GUI migration.
2. Enable exactly one concrete backend (`vault` or `external-secrets`) in environment-specific values.
3. Verify destination secret `name/key` remains stable to avoid downstream policy churn.
