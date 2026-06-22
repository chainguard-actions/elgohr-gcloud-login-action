<!-- markdownlint-disable -->

# Hardening Report: elgohr--gcloud-login-action/0.2

> This file was generated automatically by the hardening agent.

**Policy SHA:** `d636be7e43ef829af6e853da6b3c7566db9f72fe`

**Test Policy SHA:** `843adf9e4b8f85d0c08b27b9d0b09dd094b54702`

**Harden Agent Version:** `1`

Action **elgohr--gcloud-login-action/0.2** was hardened automatically. 1 finding(s) were identified and resolved across 1 iteration(s).

## Findings Fixed

### unpinned-uses (severity: high)

The Dockerfile referenced by action.yml uses the base image 'gcr.io/cloud-builders/gcloud-slim' without a SHA digest — only a mutable tag (implicitly latest). This means the action can silently pull a different (potentially malicious) image on each run. The image reference should be pinned to a specific SHA256 digest, e.g. 'gcr.io/cloud-builders/gcloud-slim@sha256:<64-hex-char-digest>'.

Locations:

- `Dockerfile:1`

## Iteration Notes

### Iteration 1

**Fixes applied:** unpinned-uses

**Notes:**

Pinned the base image in Dockerfile from 'gcr.io/cloud-builders/gcloud-slim' (mutable implicit latest tag) to 'gcr.io/cloud-builders/gcloud-slim@sha256:8eb8ff9c51b9a73ad54caa9f6b3f6cca0b254d0c3db1f4a78faec074fee36c5a # latest'. The digest was resolved using the Docker Registry HTTP API v2. The subsequent FROM runtime stages inherit the pinned image automatically.

