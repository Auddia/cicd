# Githut Action

## Important Info
* name: `setup_gcloud`
* yaml reference: `Auddia/cicd/actions/setup_gcloud@<tag>`
* action type: Composite

## Description
This reusable action pulls in the code for the repo and sets up a gcloud-sdk. It makes both the code and sdk available to all actions/steps with in the job where this action is used. 

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

[comment]: <> (##### `gcp_secrets`)

[comment]: <> (* **Description**: Secrets from GCP that you want available for other steps and actions within a job)

[comment]: <> (* Here is a [reference]&#40;https://github.com/google-github-actions/get-secretmanager-secrets#inputs&#41; for how to structure the secret string for this action)

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
```

[comment]: <> (```)

[comment]: <> (  example_job_with_secrets:)

[comment]: <> (    name: An example job that uses the gcloud sdk )

[comment]: <> (    runs-on: ubuntu-latest)

[comment]: <> (    steps:)

[comment]: <> (      - name: GCloud SDK Setup)

[comment]: <> (        uses: Auddia/cicd/actions/setup_gcloud@<tag>)

[comment]: <> (        with:)

[comment]: <> (          gcp_credentials: '${{ secrets.GCP_CREDEENTIALS }}')

[comment]: <> (          gcp_secrets: |-)

[comment]: <> (            token:my-project/docker-registry-token)

[comment]: <> (      - name: Example using the gcloud tool)

[comment]: <> (        run: 'gcloud info')
        
[comment]: <> (      - name: Reference the secret)

[comment]: <> (        uses: 'foo/bar@master')

[comment]: <> (        env:)

[comment]: <> (          TOKEN: '${{ steps.gcp_secrets.outputs.token }}')
        
[comment]: <> (```)

### Additonal Usage
* [Reuseable Workflow OpenAPI Update](../../.github/workflows/openapi_update.yml)
* [OpenAPI Update Deployment](https://github.com/Auddia/vodacast-functions/blob/staging/.github/workflows/deployments.yml#L7)
    * Note this is call to the reusable workflow from [above](../../.github/workflows/openapi_update.yml), but it is still an example of how to configure the `setup_gcloud` action.