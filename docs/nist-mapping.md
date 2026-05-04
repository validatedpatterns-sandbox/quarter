# NIST SP 800-53 metadata mapping

The quarter Tier 0 pattern does not rewrite ACM policy content. It references the external tenancy policy repository and preserves control-family metadata in place.

## Control family mapping

| NIST family | Source path | Expected metadata |
| --- | --- | --- |
| AC (Access Control) | `policygen/AC-Access-Control/policygenerator-{hub,managed}.yaml` | `categories: AC Access Control`, non-empty `controls` list |
| CM (Configuration Management) | `policygen/CM-Configuration-Management/policygenerator-{hub,managed}.yaml` | `categories: CM Configuration Management`, non-empty `controls` list |
| SC (System and Communications Protection) | `policygen/SC-System-and-Communications-Protection/policygenerator-{hub,managed}.yaml` | `categories: SC System and Communications Protection`, non-empty `controls` list |

## Verification

Run:

```bash
make verify-nist
```

By default, verification reads `./tenancy-by-acm-policy`. To validate any external checkout, set:

```bash
TENANCY_POLICY_REPO_PATH=/path/to/mirror make verify-nist
```
