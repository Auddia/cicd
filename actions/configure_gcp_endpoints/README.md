# Githut Action

## Important Info
* name: `configure_gcp_endpoints`
* yaml reference: `Auddia/cicd/actions/configure_gcp_endpoints@<tag>`
* action type: Docker Action

## Required Setup
To use this action in your repository you need to do the following steps to configure the GCP environment properly.

1. Make sure to run the [setup_gcloud action](../setup_gcloud/README.md) before using this action in a job.

2. Create Cloud Run Service by deploying ESPv2 container:
```bash
$ gcloud run deploy <API_NAME>-endpoints-cloudrun-service \
  --image="gcr.io/endpoints-release/endpoints-runtime-serverless:2" \
  --allow-unauthenticated \
  --platform managed \
  --project <GCP_PROJECT> \
  --region us-central1
```

3. Map the custom subdomain to the cloud run service by going to the GCP cloud console. First click on to `Cloud Run` and then click `Manage Custom Domains` in the top banner and add the mapping of api service to the desired domain name.
   1. **NOTE:** Make sure the domain is verified in `Cloud DNS`

4. Run the `configure_gcp_endpoints` action.

## Description
This is a custom action used for deploying updated api definitions to gcp endpoints.

This action has a few steps.

1. Deploy new/updated endpoints configuration (i.e. redeploy with update `openapi.yaml`)
2. Build a new ESPv2 image and upload it to container registry for the new endpoint configuration.
3. Redeploy Cloud Run Service with new image
4. Update the default service account privileges, so it can invoke the endpoints

### Input Arguments

##### `gcp_project`
* **Description**: The GCP project name
* `type`: `string`
* `required`: `true`

##### `api_subdomain`
* **Description**: The subdomain of the api being deployed
* `type`: `string`
* `required`: `true`

##### `default_service_account`
* **Description**: The service account you want to run the gcloud deployment commands
* `type`: `string`
* `required`: `true`

##### `openapi_yaml`
* **Description**: The location of the openapi yaml that defines the api's endpoints
* `type`: `string`
* `default`: `./open_api.yaml`

## Example Usage

```
jobs:
  example job:
    name: Configure GCP Enpoints Example
    runs-on: ubuntu-latest
    steps:
      - name: GCloud SDK Setup
        uses: Auddia/cicd/actions/setup_gcloud@<tag>
        with:
          gcp_credentials: '${{ secrets.GCP_CREDEENTIALS }}'

      - name: GCP Deployment
        uses: Auddia/cicd/actions/configure_gcp_endpoints@<tag>
        with:
          gcp_project: ${{ inputs.gcp_project }}
          api_subdomain: ${{ inputs.api_subdomain }}
          default_service_account: ${{ inputs.default_service_account }}
          openapi_yaml: ${{ inputs.openapi_yaml }}
```

### Additonal Usage
* [Reuseable Workflow OpenAPI Update](../../.github/workflows/openapi_update.yml)
* [OpenAPI Update Deployment](https://github.com/Auddia/vodacast-functions/blob/staging/.github/workflows/deployments.yml#L7)
    * Note this is call to the reusable workflow from [above](../../.github/workflows/openapi_update.yml), but it is still an example of how to configure the `configure_gcp_endpoints` action.