<!-- markdownlint-disable -->

# Hardening Report: elgohr--gcloud-login-action/0.1

> This file was generated automatically by the hardening agent.

**Policy SHA:** `d636be7e43ef829af6e853da6b3c7566db9f72fe`

**Test Policy SHA:** `843adf9e4b8f85d0c08b27b9d0b09dd094b54702`

**Harden Agent Version:** `2`

Action **elgohr--gcloud-login-action/0.1** was hardened automatically. 2 finding(s) were identified and resolved across 1 iteration(s).

## Findings Fixed

### unpinned-uses (severity: high)

The workflow file uses `actions/checkout@master`, which is pinned to a mutable branch name rather than an immutable 40-character commit SHA. This means the action could be silently updated to a different (potentially malicious) version without any change to the workflow file. It should be pinned to a full SHA, e.g. `actions/checkout@11bd71901bbe5b1630ceea73d27597364c9af683 # v4`.

Locations:

- `.github/workflows/test.yml:7`

### missing-permissions (severity: medium)

The workflow file has no top-level `permissions:` key, and the only job (`build`) also has no job-level `permissions:` key. Without explicit permissions, the workflow inherits the repository's default token permissions, which may be broader than necessary. A minimal `permissions:` block (e.g. `contents: read`) should be added at the top level or on the job.

Locations:

- `.github/workflows/test.yml:1`

## Iteration Notes

### Iteration 1

**Fixes applied:** unpinned-uses, missing-permissions

**Notes:**

In hardened/action/.github/workflows/test.yml: (1) Pinned `actions/checkout@master` to the full commit SHA `34e114876b0b11c390a56381ad16ebd13914f8d5` (v4) to prevent silent updates via a mutable branch reference. (2) Added a top-level `permissions: contents: read` block to restrict the GITHUB_TOKEN to the minimum permissions needed for this workflow.

