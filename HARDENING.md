<!-- markdownlint-disable -->

# Hardening Report: elgohr--gcloud-login-action/0.3

> This file was generated automatically by the hardening agent.

**Policy SHA:** `d636be7e43ef829af6e853da6b3c7566db9f72fe`

**Test Policy SHA:** `843adf9e4b8f85d0c08b27b9d0b09dd094b54702`

**Harden Agent Version:** `2`

Action **elgohr--gcloud-login-action/0.3** was hardened automatically. 2 finding(s) were identified and resolved across 1 iteration(s).

## Findings Fixed

### unpinned-uses (severity: high)

Multiple workflow files reference GitHub Actions using mutable tags or branch names instead of pinned full-length SHA commit hashes. This exposes the workflow to supply-chain attacks if the referenced action is compromised or its tag is moved.

- `.github/workflows/assign.yml`: `uses: pozil/auto-assign-issue@v1` (mutable tag)
- `.github/workflows/automerge.yml`: `uses: octokit/graphql-action@v2.x` (mutable branch/tag, used twice)
- `.github/workflows/test.yml`: `uses: actions/checkout@master` (mutable branch)

Locations:

- `.github/workflows/assign.yml:8`
- `.github/workflows/automerge.yml:9`
- `.github/workflows/automerge.yml:22`
- `.github/workflows/test.yml:7`

### missing-permissions (severity: medium)

None of the workflow files define a top-level `permissions:` block, and no job within them defines job-level permissions. Without explicit permissions, workflows run with the default (often broad) token permissions, violating the principle of least privilege. This affects all three workflow files: assign.yml, automerge.yml, and test.yml. Notably, automerge.yml uses the sensitive `pull_request_target` trigger and writes to the repository via a GraphQL mutation, making the absence of scoped permissions especially risky.

Locations:

- `.github/workflows/assign.yml:1`
- `.github/workflows/automerge.yml:1`
- `.github/workflows/test.yml:1`

## Iteration Notes

### Iteration 1

**Fixes applied:** unpinned-uses, missing-permissions

**Notes:**

Fixed all three workflow files:

1. assign.yml: Pinned pozil/auto-assign-issue@v1 to full SHA d11e715efc663fe323c3d8d4d3cbbfdddd539baf. Added top-level `permissions: {}` and job-level `permissions: { issues: write }` (needed to assign issues via GITHUB_TOKEN).

2. automerge.yml: Pinned both octokit/graphql-action@v2.x references to full SHA f7836e89a7e5bac63911bbe9653c21147b3d9bc3. Added top-level and job-level `permissions: {}` — the GraphQL mutations use the custom AUTO_UPDATE secret token rather than GITHUB_TOKEN, so no GITHUB_TOKEN permissions are needed.

3. test.yml: Pinned actions/checkout@master to full SHA 61b9e3751b92087fd0b06925ba6dd6314e06f089. Added top-level and job-level `permissions: {}` since the job only builds a Docker image and needs no token permissions.

