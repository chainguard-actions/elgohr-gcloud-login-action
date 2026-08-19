<!-- markdownlint-disable -->

# Hardening Report: elgohr--gcloud-login-action/0.2

> This file was generated automatically by the hardening agent.

**Policy SHA:** `d636be7e43ef829af6e853da6b3c7566db9f72fe`

**Test Policy SHA:** `843adf9e4b8f85d0c08b27b9d0b09dd094b54702`

**Harden Agent Version:** `2`

Action **elgohr--gcloud-login-action/0.2** was hardened automatically. 2 finding(s) were identified and resolved across 1 iteration(s).

## Findings Fixed

### unpinned-uses (severity: high)

The workflow file uses `actions/checkout@master`, which is pinned to a mutable branch name rather than an immutable 40-character commit SHA. This means the action could be silently updated to a different (potentially malicious) version without any change to the workflow file.

Locations:

- `.github/workflows/test.yml:7`

### permissions (severity: medium)

The workflow file has no top-level `permissions:` key and the `build` job also has no job-level `permissions:` key. Without explicit permissions, the workflow inherits the default repository permissions (which can include broad write access), violating the principle of least privilege.

Locations:

- `.github/workflows/test.yml:1`

## Iteration Notes

### Iteration 1

**Fixes applied:** unpinned-uses, permissions

**Notes:**

Fixed hardened/action/.github/workflows/test.yml: (1) Pinned actions/checkout@master to its full commit SHA (61b9e3751b92087fd0b06925ba6dd6314e06f089) with a # master comment for readability. (2) Added `permissions: {}` at both the top-level workflow and the `build` job level to enforce least privilege — the workflow only runs `docker build .` and needs no GitHub API permissions.

