# Tested-tier roadmap

This roadmap tracks promotion from sandbox to tested tier.

## Milestone 1: deterministic install

- [ ] Run `./pattern.sh make install` on a fresh cluster and record timing + outcomes
- [ ] Confirm no manual post-install commands are required
- [ ] Capture known prerequisites in `README.md`

## Milestone 2: repeatable validation

- [ ] Execute `tests/test-plan.md` on at least one supported OCP release
- [ ] Publish outcomes to `tests/latest-results.json`
- [ ] Document failure triage workflow for broken checks

## Milestone 3: quarterly cadence

- [ ] Establish quarterly rerun owner
- [ ] Update `tests/latest-results.json` each quarter
- [ ] Open remediation issues for any failed checks

## Milestone 4: tested-tier nomination package

- [ ] Confirm business use case and demo narrative are complete in `README.md`
- [ ] Verify architecture and written guide are current
- [ ] Submit nomination evidence package with latest test JSON
