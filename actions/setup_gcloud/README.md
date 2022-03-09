# Githut Action

## Important Info
* name: `setup_gcloud`
* yaml reference: `Auddia/cicd/actions/setup_gcloud@<tag>`
* action type: Composite

## Description
This reusable action pulls in the code for the repo, sets up a gcloud-sdk, and retrieves GCP secrets. 
It makes both the code, sdk, and secrets available to all actions/steps with in the job where this action is used. 

#### sdk made available in the following step/action types
* [Composite Actions](https://docs.github.com/en/actions/creating-actions/creating-a-composite-action) 
  * The code maybe in a wierd (i.e. non-default directory but it is there)
* [Docker Actions](https://docs.github.com/en/actions/creating-actions/creating-a-docker-container-action)
    * Tested image: [`google/cloud-sdk`](https://hub.docker.com/r/google/cloud-sdk/)
    * The code maybe in a wierd (i.e. non-default directory but it is there)
* Other action types not tested

The sdk is available in all steps and within docker as long as you use the [`google/cloud-sdk`](https://hub.docker.com/r/google/cloud-sdk/) image

### Input Arguments

##### `gcp_cedentials`
* **Description**: A github secret containing the json api key from google for the desired service account that will be issuing the commands from the `gcloud` cli.
* References the repo's available secrets and the github group's (i.e. `Auddia`) available secrets
* If the needed credentials secret doesnt exist and you need to add one follow this [guide](https://cloud.google.com/docs/authentication/getting-started#create-service-account-console) to generate the json value that you will assign the secret. NOTE: You need admin privileges to add a secret to a repo or group

##### `gcp_secrets`
* **Description**: Secrets from GCP that you want available for other steps and actions within a job
* Here is a [reference](https://github.com/google-github-actions/get-secretmanager-secrets#inputs) for how to structure the secret string for this action


### Output

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

## Example Usage

```
jobs:
  example_job_no_secrets:
    name: An example job that uses the gcloud sdk 
    runs-on: ubuntu-latest
    steps:
      - name: GCloud SDK Setup
        uses: Auddia/cicd/actions/setup_gcloud@<tag>
        with:
          gcp_credentials: '${{ secrets.GCP_CREDEENTIALS }}'

      - name: Example using the gcloud tool
        run: 'gcloud info'

  example_job_with_secrets:
    name: An example job that uses the gcloud sdk 
    runs-on: ubuntu-latest
    steps:
      - name: GCloud SDK Setup
        id: gcp
        uses: Auddia/cicd/actions/setup_gcloud@<tag>
        with:
          gcp_credentials: '${{ secrets.GCP_CREDEENTIALS }}'
          gcp_secrets: |-
            TOKEN:my-project/docker-registry-token

      - name: Example using the gcloud tool
        run: 'gcloud info'
        
      - name: Reference the secret
        uses: 'foo/bar@master'
        env:
          TOKEN: '${{ fromJson(steps.gcp.outputs.secrets).TOKEN }}'
```

### Additonal Usage
* [Reuseable Workflow OpenAPI Update](../../.github/workflows/openapi_update.yml)
* [Reuseable Workflow Cloud Run API Deployment](../../.github/workflows/cloud_run_api_deployment.yml)
* [Dynamic Usage of Secrets Usage](../build_and_publish_image/action.yaml)
* [OpenAPI Update Deployment](https://github.com/Auddia/vodacast-functions/blob/staging/.github/workflows/deployments.yml#L7)
    * Note this is call to the reusable workflow from [above](../../.github/workflows/openapi_update.yml), but it is still an example of how to configure the `setup_gcloud` action.
* [API Deployment](FILL IN)
    * Note this is call to the reusable workflow from [above](../../.github/workflows/cloud_run_api_deployment.yml), but it is still an example of how to configure the `setup_gcloud` action.