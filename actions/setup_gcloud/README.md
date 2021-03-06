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

##### `gcp_cedentials`
* **Description**: The json api key from google for the desired service account that will be issuing the commands from the `gcloud` cli.
* `type`: `string`
* `required`
* NOTE: If the needed credentials secret doesnt exist and you need to add one follow this [guide](https://cloud.google.com/docs/authentication/getting-started#create-service-account-console) to generate the json value that you will assign the secret. NOTE: You need admin privileges to add a secret to a repo or group


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

```yaml
jobs:
  example_job_no_secrets:
    name: 'An example job that uses the gcloud sdk'
    runs-on: ubuntu-latest
    steps:
      - name: 'GCloud SDK Setup'
        uses: Auddia/cicd/actions/setup_gcloud@<tag>
        with:
          gcp_credentials: ${{ secrets.GCP_CREDEENTIALS }}

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