# quarter tested-tier test plan (backlog)

This plan is not required for initial sandbox nomination, but defines the path to tested-tier evidence.

## Scope

- Hub bootstrap (`./pattern.sh make install`)
- PolicyGenerator plugin patch on `openshift-gitops` repo-server
- GitOps sync of tenancy base + placements + AC/CM/SC applications
- Tenant GUI deployment and console plugin activation
- Tenant lifecycle effect on managed clusters

## Environment matrix

| Scenario | OCP version | Platform | Frequency |
| --- | --- | --- | --- |
| Hub-only install | Current supported GA | Any supported IPI/UPI | Quarterly |
| Hub + at least one managed cluster | Current supported GA | Same as above | Quarterly |

## Test cases

1. Install from clean cluster:
   - run `./pattern.sh make install`
   - verify all Applications `Synced/Healthy`
2. PolicyGenerator readiness:
   - verify repo-server restart completed
   - confirm policy applications render without plugin errors
3. NIST metadata retention:
   - review control-family metadata in the external tenancy policy repository
4. Tenant creation path:
   - create a test `Tenant` CR (via GUI or API)
   - verify namespace, RBAC, quota, and UDN resources on selected managed cluster
5. Console plugin path:
   - verify `ConsolePlugin` object exists
   - verify plugin is listed in `console.operator/cluster.spec.plugins`

## Exit criteria

- All test cases pass once per quarter for nominated OCP version.
- Latest result is recorded in `tests/latest-results.json`.
