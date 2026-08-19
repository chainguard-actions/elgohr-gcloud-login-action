<!-- markdownlint-disable -->

# Hardening Report: elgohr--gcloud-login-action/v2

> This file was generated automatically by the hardening agent.

**Policy SHA:** `d636be7e43ef829af6e853da6b3c7566db9f72fe`

**Test Policy SHA:** `843adf9e4b8f85d0c08b27b9d0b09dd094b54702`

**Harden Agent Version:** `2`

Action **elgohr--gcloud-login-action/v2** was hardened automatically. 2 finding(s) were identified and resolved across 1 iteration(s).

## Findings Fixed

### unpinned-uses (severity: high)

Workflow files reference actions using mutable tag/version refs instead of pinned 40-character commit SHAs. This exposes the workflow to supply-chain attacks if the tag is moved. Failing references: release.yml uses 'actions/checkout@v3' (twice); assign.yml uses 'pozil/auto-assign-issue@v1'.

Locations:

- `.github/workflows/release.yml:13`
- `.github/workflows/release.yml:22`
- `.github/workflows/assign.yml:8`

### missing-permissions (severity: medium)

release.yml has no top-level 'permissions:' key, and the 'release' job has no job-level 'permissions:' block (only the 'test' job does). This means the 'release' job runs with the default, overly broad token permissions. assign.yml has no top-level 'permissions:' key and the 'auto-assign' job has no job-level 'permissions:' block either.

Locations:

- `.github/workflows/release.yml:1`
- `.github/workflows/assign.yml:1`

## Iteration Notes

### Iteration 1

**Fixes applied:** unpinned-uses, missing-permissions

**Notes:**

release.yml: pinned both actions/checkout@v3 references to SHA f43a0e5ff2bd294095638e18286ca9a3d1956744, added top-level `permissions: {}`, and added `permissions: contents: write` to the release job (needed for git tag push). assign.yml: pinned pozil/auto-assign-issue@v1 to SHA d11e715efc663fe323c3d8d4d3cbbfdddd539baf, added top-level `permissions: {}`, and added `permissions: issues: write` to the auto-assign job (needed to assign issues via GITHUB_TOKEN).

