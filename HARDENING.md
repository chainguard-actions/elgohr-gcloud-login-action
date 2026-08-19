<!-- markdownlint-disable -->

# Hardening Report: elgohr--gcloud-login-action/v1

> This file was generated automatically by the hardening agent.

**Policy SHA:** `d636be7e43ef829af6e853da6b3c7566db9f72fe`

**Test Policy SHA:** `843adf9e4b8f85d0c08b27b9d0b09dd094b54702`

**Harden Agent Version:** `2`

Action **elgohr--gcloud-login-action/v1** was hardened automatically. 3 finding(s) were identified and resolved across 2 iteration(s).

## Findings Fixed

### unpinned-uses (severity: high)

Workflow files reference actions using mutable tags instead of pinned full-length SHA digests, making the workflow vulnerable to supply-chain attacks if the tag is moved.

- `.github/workflows/assign.yml`: `uses: pozil/auto-assign-issue@v1`
- `.github/workflows/release.yml`: `uses: actions/checkout@v3` (appears twice, in both the `test` and `release` jobs)

All three should be pinned to a full 40-character commit SHA (e.g. `actions/checkout@11bd71901bbe5b1630ceea73d27597364c9af683 # v3`).

Locations:

- `.github/workflows/assign.yml:6`
- `.github/workflows/release.yml:15`
- `.github/workflows/release.yml:24`

### missing-permissions (severity: medium)

`.github/workflows/assign.yml` has no top-level `permissions:` key and its only job (`auto-assign`) also has no job-level `permissions:` key. Without explicit permissions the workflow inherits the repository's default token permissions, which may be broader than necessary.

Locations:

- `.github/workflows/assign.yml:1`

### missing-permissions (severity: medium)

`.github/workflows/release.yml` has no top-level `permissions:` key. The `test` job defines `permissions: contents: read`, but the `release` job has no `permissions:` key at all. Because not every job has its own permissions block, the `release` job inherits the repository's default token permissions (which may include `contents: write` needed to push tags, but is not explicitly scoped), violating the principle of least privilege.

Locations:

- `.github/workflows/release.yml:19`

## Iteration Notes

### Iteration 1

**Fixes applied:** unpinned-uses, missing-permissions

**Notes:**

Fixed all three findings:
1. assign.yml: Pinned pozil/auto-assign-issue@v1 to full SHA d11e715efc663fe323c3d8d4d3cbbfdddd539baf. Added top-level `permissions: {}` and job-level `permissions: issues: write`.
2. release.yml: Pinned both actions/checkout@v3 references to full SHA a37ce9120846195fa4ece8f58b268e6043cb2f26. Added top-level `permissions: {}` and job-level `permissions: contents: write` to the release job (needed to push tags). The test job already had `permissions: contents: read`.

### Iteration 2

**Fixes applied:** github-env-injection

**Notes:**

Fixed entrypoint.sh line 9: replaced direct `echo "password=${TOKEN}" >> "$GITHUB_ENV"` with a two-step approach that first sanitizes the token using `safe_token=$(printf '%s' "${TOKEN}" | tr -d '\n\r')` to strip newline/carriage-return characters, then writes `echo "password=${safe_token}" >> "$GITHUB_ENV"`. This prevents a token value containing newline characters from injecting additional key=value pairs into the GitHub environment.

