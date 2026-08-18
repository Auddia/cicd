# Project GEMINI: Auddia CI/CD Architecture & Collaboration Guide

This document serves as the primary technical context and operational guide for AI agents and engineers collaborating on the `Auddia/cicd` repository.

---

## 1. Purpose and Overview

The **`Auddia/cicd`** repository is the centralized infrastructure repository providing shared, reusable GitHub Actions and GitHub Workflows for all projects across the Auddia ecosystem.

Its primary objectives are:
* **Standardize CI/CD Pipelines:** Provide unified workflows for automated testing, container image building, and cloud deployments.
* **Streamline Cloud Deployments:** Abstract interactions with Google Cloud Platform (GCP) services, including Google Cloud Run, Google Cloud Functions (v1/beta), Cloud Endpoints, Secret Manager, and Cloud KMS.
* **Secure Credential and Dependency Management:** Handle private GitHub dependency resolution (SSH deploy keys), KMS decryption, and Secret Manager access securely across automated runners.
* **Versioned Reusability:** Enable downstream consumer repositories to consume versioned pipeline templates (`workflow_call`) and composite/Docker actions.

---

## 2. Core Technologies

* **GitHub Actions Ecosystem:**
  * Reusable Workflows (`workflow_call`)
  * Composite Actions (`runs.using: composite`)
  * Container Actions (`runs.using: docker`)
  * Dispatch testing (`workflow_dispatch`)
* **Google Cloud Platform (GCP):**
  * `google-github-actions/auth@v2` and `google-github-actions/setup-gcloud@v2`
  * Google Cloud Run (`gcloud run` / `gcloud beta run`)
  * Google Cloud Functions (`gcloud beta functions deploy`)
  * Google Cloud Endpoints (`gcloud endpoints services deploy`) & Extensible Service Proxy (ESP)
  * GCP Secret Manager (`google-github-actions/get-secretmanager-secrets@v2`)
  * GCP Cloud KMS (`gcloud kms decrypt`)
  * Google Container Registry (`gcr.io`)
* **Docker & Container Tooling:**
  * Docker CLI & Docker BuildKit (`DOCKER_BUILDKIT=1`, `--ssh` mounts)
  * Node.js containerized CLI tools (`@redocly/cli`, `@apidevtools/swagger-cli`)
* **Languages & Scripting:**
  * Bash / POSIX Shell (`/bin/bash`, `/bin/sh`, `awk`, `xargs`, `sed`, `tr`)
  * Python 3.7+ & `pytest` (test runners and matrix builds)
* **SSH & Git:**
  * `webfactory/ssh-agent@v0.5.4` for private repository deploy keys

---

## 3. Architecture and Main Components

The codebase is organized into four distinct tiers:

```
cicd/
├── .github/
│   └── workflows/          # Reusable workflow templates & test harnesses
├── actions/                # Modular custom actions (Composite & Docker)
├── resources/              # Mock fixtures, sample code, and test configs
├── scripts/                # Shell utility functions and test assertions
└── docs/                   # Documentation and release changelogs
```

### A. Reusable Workflows (`.github/workflows/`)
Top-level workflows meant to be called by downstream repositories via `uses: Auddia/cicd/.github/workflows/<workflow_name>.yml@<version>`:
1. **`cloud_run_api_deployment.yml`**: Full pipeline to set up GCP authentication, load Secret Manager secrets, configure SSH deploy keys, decrypt KMS files, build & tag a Docker image with BuildKit, push to GCR, and deploy to Cloud Run.
2. **`gcp_function_deployment.yml`**: Pipeline for packaging and deploying Google Cloud Functions, installing private Python dependencies into `packages/`, formatting environment variables and secrets, and deploying via `gcloud beta functions deploy`.
3. **`openapi_update.yml`**: Compiles multi-file OpenAPI template YAMLs and configures/deploys GCP Cloud Endpoints service definitions and proxies.
4. **`python_test.yml`**: Multi-version Python test harness executing `pytest` with matrix builds, optional SSH support for private dependencies, and JUnit XML test reporting (`EnricoMi/publish-unit-test-result-action`).

### B. Custom Actions (`actions/`)
Encapsulated steps reused within workflows or directly by consumer repositories:
1. **`setup_gcloud/`** (*Composite*): Authenticates service accounts, sets up Cloud SDK with `beta` components, and conditionally fetches GCP Secret Manager secrets.
2. **`build_and_publish_image/`** (*Composite*): Prepares `--build-arg` parameters from config strings, builds Docker images using BuildKit with optional SSH agent forwarding, and pushes to GCR.
3. **`compile_openapi/`** (*Docker*): Bundles split OpenAPI YAML files using `@redocly/cli` and `@apidevtools/swagger-cli` in a containerized Node runtime.
4. **`configure_gcp_endpoints/`** (*Docker*): Deploys OpenAPI definitions to Cloud Endpoints, builds runtime proxy images, and configures IAM policy bindings (`roles/run.invoker` / `roles/cloudfunctions.invoker`).
5. **`decrypt_kms_secrets/`** (*Composite*): Parses a formatted decryption manifest (`ciphertext : key : plaintext`) and runs `gcloud kms decrypt` across all targets.

### C. Test Harnesses and Resources
* **`test.*.yml`**: Manual dispatch workflows targeting actions and workflows with test inputs.
* **`todo.test.*.yml`**: Placeholders for test cases requiring mocked GCP infrastructure.
* **`resources/`**: Test templates, sample Docker environments, encrypted key files, and Python packages used by test workflows.
* **`scripts/test_functions.sh`**: Shell assertions (`fail_if_empty_string`, `strings_equal`, etc.).

---

## 4. Key Files and Entrypoints

| Category | Path | Description |
| :--- | :--- | :--- |
| **Workflow** | [`.github/workflows/cloud_run_api_deployment.yml`](file:///Users/pcr/Projects/shell/cicd/.github/workflows/cloud_run_api_deployment.yml) | Reusable Cloud Run deployment template |
| **Workflow** | [`.github/workflows/gcp_function_deployment.yml`](file:///Users/pcr/Projects/shell/cicd/.github/workflows/gcp_function_deployment.yml) | Reusable Cloud Functions deployment template |
| **Workflow** | [`.github/workflows/openapi_update.yml`](file:///Users/pcr/Projects/shell/cicd/.github/workflows/openapi_update.yml) | Reusable OpenAPI / Cloud Endpoints template |
| **Workflow** | [`.github/workflows/python_test.yml`](file:///Users/pcr/Projects/shell/cicd/.github/workflows/python_test.yml) | Reusable Python pytest matrix template |
| **Action** | [`actions/setup_gcloud/action.yml`](file:///Users/pcr/Projects/shell/cicd/actions/setup_gcloud/action.yml) | GCP Auth & Secret Manager composite action |
| **Action** | [`actions/build_and_publish_image/action.yaml`](file:///Users/pcr/Projects/shell/cicd/actions/build_and_publish_image/action.yaml) | Docker build & push composite action |
| **Action** | [`actions/compile_openapi/Dockerfile`](file:///Users/pcr/Projects/shell/cicd/actions/compile_openapi/Dockerfile) | Node Docker environment for OpenAPI tooling |
| **Action** | [`actions/configure_gcp_endpoints/deployment_script.sh`](file:///Users/pcr/Projects/shell/cicd/actions/configure_gcp_endpoints/deployment_script.sh) | GCP Cloud Endpoints deployment orchestrator |
| **Action** | [`actions/decrypt_kms_secrets/action.yml`](file:///Users/pcr/Projects/shell/cicd/actions/decrypt_kms_secrets/action.yml) | Cloud KMS secret decryptor |
| **Docs** | [`docs/DEPLOY_KEYS.md`](file:///Users/pcr/Projects/shell/cicd/docs/DEPLOY_KEYS.md) | Guide for multi-repo SSH deploy keys |
| **Docs** | [`README.md`](file:///Users/pcr/Projects/shell/cicd/README.md) | Main repository guide and catalog |

---

## 5. Coding Conventions and Style

1. **GitHub Actions Syntax:**
   * Always use current GitHub Actions step outputs syntax: `echo "<key>=<value>" >> "$GITHUB_OUTPUT"`. Never use deprecated `::set-output`.
   * Explicitly declare input types (`type: string`, `type: boolean`) and provide defaults where optional.
   * Explicitly specify shell: `shell: bash` for all composite run steps.
2. **Security & Secrets:**
   * Never echo or log secret values in build logs.
   * Avoid persistent storage of sensitive keys on disk unless explicitly required and cleaned up.
   * Follow the multi-key SSH agent convention outlined in `docs/DEPLOY_KEYS.md`.
3. **Shell Scripting:**
   * Always quote variable expansions (`"$VAR"`, `"${{ inputs.name }}"`) to prevent word-splitting and injection.
   * Prefer POSIX-compatible scripting or explicitly specify `#!/usr/bin/env bash` when Bash features are used.
   * Test edge cases for empty strings or missing variables before executing GCP commands.
4. **Dockerfiles:**
   * Use active, LTS base images with explicit version tags (e.g., `node:20.19.0`).

---

## 6. Development, Versioning, and Testing Workflow

### Release & Tagging Lifecycle
* **Semantic Version Tags:** Release versions are tagged sequentially (`v1.4.3`, `v1.4.4`, `v1.4.5`, etc.).
* **Relationship Between `main` and Release Tags:**
  * Feature branches are merged into `main`.
  * Untested or newly merged features reside on `main`.
  * Stable milestones are tagged with release tags.
  * **Critical Dependency Note:** Reusable workflows in `.github/workflows/` often reference composite actions using `uses: Auddia/cicd/actions/<action_name>@main`. When testing or releasing new tags, verify whether internal action references need pinning or validation against `main`.
* **Testing Changes:**
  * Automated workflows cannot be fully tested locally without GCP access; use `.github/workflows/test.*.yml` via GitHub `workflow_dispatch` with appropriate staging credentials.
  * For OpenAPI compilation and shell utilities, run container/shell verification locally before submitting PRs.

---

## 7. Specific Instructions for AI Collaboration

* **Strict Backward Compatibility:** Changes to workflow inputs, action parameters, or output schemas directly affect all consuming repositories across the organization. Never remove or rename existing inputs/outputs without creating an explicit transition plan.
* **Trace All Usages:** When modifying an action in `actions/`, inspect all workflows in `.github/workflows/` to ensure calls remain aligned.
* **Keep Docs and Releases Synchronized:**
  * When introducing new features or inputs, update both the action/workflow README in `actions/<name>/README.md` / `docs/workflows/` and the main `README.md`.
  * For new release tags, create the corresponding changelog file in `docs/releases/v<version>.md`.
* **Verify Runner Compatibility:** Keep third-party action versions (e.g. `actions/checkout`, `google-github-actions/*`, `webfactory/ssh-agent`) up to date to avoid GitHub Actions runner deprecation warnings.
