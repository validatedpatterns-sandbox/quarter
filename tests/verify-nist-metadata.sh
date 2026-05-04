#!/usr/bin/env bash
set -euo pipefail

REPO_PATH="${TENANCY_POLICY_REPO_PATH:-./tenancy-by-acm-policy}"

if [[ ! -d "${REPO_PATH}" ]]; then
  echo "ERROR: Tenancy policy repository path not found: ${REPO_PATH}"
  echo "Set TENANCY_POLICY_REPO_PATH to a local checkout of the external policy repo."
  exit 1
fi

declare -A expected_category=(
  ["AC-Access-Control"]="AC Access Control"
  ["CM-Configuration-Management"]="CM Configuration Management"
  ["SC-System-and-Communications-Protection"]="SC System and Communications Protection"
)

failures=0
for family in "${!expected_category[@]}"; do
  for mode in hub managed; do
    file="${REPO_PATH}/policygen/${family}/policygenerator-${mode}.yaml"
    if [[ ! -f "${file}" ]]; then
      echo "ERROR: Missing ${file}"
      failures=$((failures + 1))
      continue
    fi

    if ! grep -Eq "categories:[[:space:]]*$" "${file}" || ! grep -Eq "standards:[[:space:]]*$" "${file}" || ! grep -Eq "controls:[[:space:]]*$" "${file}"; then
      echo "ERROR: Missing standards/categories/controls block in ${file}"
      failures=$((failures + 1))
    fi

    if ! grep -Fq "${expected_category[${family}]}" "${file}"; then
      echo "ERROR: Missing expected category '${expected_category[${family}]}' in ${file}"
      failures=$((failures + 1))
    fi

  done
done

if [[ ${failures} -gt 0 ]]; then
  echo "NIST metadata verification failed with ${failures} issue(s)."
  exit 1
fi

echo "NIST metadata verification passed for AC/CM/SC policy generator files."
