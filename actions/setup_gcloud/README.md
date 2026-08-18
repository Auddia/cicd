# Githut Action

## Important Info
* name: `setup_gcloud`
* yaml reference: `Auddia/cicd/actions/setup_gcloud@<tag>`
* action type: Composite

## Description
This reusable action pulls in the code for the repo, sets up a gcloud-sdk, and retrieves GCP secrets. 
It makes both the code, sdk, and secrets available to all actions/steps with in the job where this action is used. 

### Tags
This action is available on tags `v0` and above

#### sdk made available in the following step/action types
* [Composite Actions](https://docs.github.com/en/actions/creating-actions/creating-a-composite-action) 
  * The code maybe in a weird (i.e. non-default directory but it is there)
* [Docker Actions](https://docs.github.com/en/actions/creating-actions/creating-a-docker-container-action)
    * Tested image: [`google/cloud-sdk`](https://hub.docker.com/r/google/cloud-sdk/)
    * The code maybe in a wierd (i.e. non-default directory but it is there)
* Other action types not tested

The sdk is available in all steps and within docker as long as you use the [`google/cloud-sdk`](https://hub.docker.com/r/google/cloud-sdk/) image

### Input Arguments

##### `workload_identity_provider` *(Recommended for Keyless Auth)*
* **Description**: The full Workload Identity Provider resource name (e.g. `projects/1234567890/locations/global/workloadIdentityPools/github-actions-pool/providers/github-provider`).
* `type`: `string`
* `optional` (default: `''`)

##### `service_account` *(Required when using WIF)*
* **Description**: The email address of the GCP service account to impersonate via Workload Identity Federation (e.g. `github-actions-deploy@cfr-projects-staging.iam.gserviceaccount.com`).
* `type`: `string`
* `optional` (default: `''`)

##### `project_id`
* **Description**: The GCP project ID (optional override for authentication).
* `type`: `string`
* `optional` (default: `''`)

##### `gcp_credentials` *(Legacy Key Auth)*
* **Description**: The JSON API key from Google for the desired service account. Optional if using `workload_identity_provider`.
* `type`: `string`
* `optional` (default: `''`)


##### `gcp_secrets`
* **Description**: Secrets from GCP that you want available for other steps and actions within a job
* Here is a [reference](https://github.com/google-github-actions/get-secretmanager-secrets#inputs) for how to structure the secret string for this action
* Syntax
```yaml
gcp_secrets: |
  TEST_ONE: projects/vodacast-staging/secrets/vodacast-postgres-password
  TEST_TWO: projects/vodacast-staging/secrets/vodacast-postgres-password
```

### Output
The secrets gathered in this step are made available to all subsequent steps and action within the same job.

##### `secrets`
* **Description**: The secrets from gcp that were requested via the `gcp_secrets` argument.
* Explicit reference
```yaml
fromJson(steps.gcp.outputs.secrets).TOKEN
fromJson(steps.gcp.outputs.secrets)['TOKEN']
```
* [Example of a Dynamic Reference](../build_and_publish_image/action.yaml)
```yaml
# Where secret_args is assumed to be the output of this action.  
echo "$secret_args" | grep ":" | tr -d "[\":]" > input.txt
additional_args=$(awk '{print "--build-arg "$1"="$2}' input.txt)
echo "additional_build_args=${value} ${additional_args}" >> $GITHUB_ENV
```

##### `has_secrets`
* **Description**: A boolean flag to show if secrets were acquired by this step.
* This is needed due to an issue with the `secrets` output when no secrets are passed into this step

## Example Usage

### 1. Keyless Workload Identity Federation (Recommended)
```yaml
jobs:
  example_job_wif:
    name: 'Keyless GCP Deployment via Workload Identity Federation'
    runs-on: ubuntu-latest
    permissions:
      contents: read
      id-token: write  # Required for OIDC token exchange
    steps:
      - name: 'GCloud SDK Setup via WIF'
        uses: Auddia/cicd/actions/setup_gcloud@<tag>
        with:
          workload_identity_provider: 'projects/156247944579/locations/global/workloadIdentityPools/github-actions-pool/providers/github-provider'
          service_account: 'github-actions-deploy@cfr-projects-staging.iam.gserviceaccount.com'

      - name: 'Example using the gcloud tool'
        run: gcloud info
```

### 2. Legacy Service Account Key Auth
```yaml
jobs:
  example_job_no_secrets:
    name: 'An example job that uses the gcloud sdk'
    runs-on: ubuntu-latest
    steps:
      - name: 'GCloud SDK Setup'
        uses: Auddia/cicd/actions/setup_gcloud@<tag>
        with:
          gcp_credentials: ${{ secrets.GCP_CREDENTIALS }}

      - name: 'Example using the gcloud tool'
        run: gcloud info

  example_job_with_secrets:
    name: 'An example job that uses the gcloud sdk'
    runs-on: ubuntu-latest
    steps:
      - name: 'GCloud SDK Setup'
        id: gcp
        uses: Auddia/cicd/actions/setup_gcloud@<tag>
        with:
          gcp_credentials: ${{ secrets.GCP_CREDEENTIALS }}
          gcp_secrets: |-
            TOKEN:my-project/docker-registry-token

      - name: 'Example using the gcloud tool'
        run: gcloud info
        
      - name: 'Reference the secret'
        if: ${{ steps.gcp.outputs.has_secrets }} == true
        uses: foo/bar@master
        env:
          TOKEN: ${{ fromJson(steps.gcp.outputs.secrets).TOKEN }}
```

### Additonal Usage
* [Tests](../../.github/workflows/test.action.setup_gcloud.yml)
* [Reuseable Workflow OpenAPI Update](../../.github/workflows/openapi_update.yml)
* [Reuseable Workflow Cloud Run API Deployment](../../.github/workflows/cloud_run_api_deployment.yml)
* [Dynamic Usage of Secrets Usage](../build_and_publish_image/action.yaml)