# Githut Action

## Important Info
* name: `setup_gcloud`
* yaml reference: `Auddia/cicd/actions/setup_gcloud@main`
* action type: Docker Action

## Description
This reusable action pulls in the code for the repo and sets up a gcloud-sdk. It makes both the code and sdk available to all actions/steps with in the job where this action is used. 

#### sdk available in the following step/action types
* [Composite Actions](https://docs.github.com/en/actions/creating-actions/creating-a-composite-action) 
* [Docker Actions](https://docs.github.com/en/actions/creating-actions/creating-a-docker-container-action)
    * Tested image: [`google/cloud-sdk`](https://hub.docker.com/r/google/cloud-sdk/)
* Other action types not tested

The sdk is available in all steps and within docker as long as you use the [`google/cloud-sdk`](https://hub.docker.com/r/google/cloud-sdk/) image

### Input Arguments

##### `gcp_cedentials`
* Description: A github secret containing the json api key from google for the desired service account that will be issuing the commands from the `gcloud` cli.
* Reference the repo's available secrets and the github group's (i.e. `Auddia`) available secrets
* If the needed credentials secret doesnt exist and you need to add one follow this [guide](https://cloud.google.com/docs/authentication/getting-started#create-service-account-console) to generate the json value that you will assign the secret. NOTE: You need admin priveledges to add a secret to a repo or group


## Example Usage

```
jobs:
  example_job:
    name: An example job that uses the gcloud sdk 
    runs-on: ubuntu-latest
    steps:
      - name: GCloud SDK Setup
        uses: Auddia/cicd/actions/setup_gcloud@<github version tag>
        with:
          gcp_credentials: '${{ secrets.GCP_CREDEENTIALS }}'

      - name: Example using the gcloud tool
        run: 'gcloud info'
```

### Additonal Usage
* [Reuseable Workflow OpenAPI Update](https://github.com/Auddia/cicd/blob/main/.github/workflows/openapi_update.yml#L50)
* [OpenAPI Update Deployment](https://github.com/Auddia/vodacast-functions/blob/staging/.github/workflows/deployments.yml#L7)
    * Note this is call to the reusable workflow from [above](https://github.com/Auddia/cicd/blob/main/.github/workflows/openapi_update.yml#L50), but it is still an example of how to configure the `setup_gcloud` action.