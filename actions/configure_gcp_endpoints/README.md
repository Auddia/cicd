# Githut Action

## Important Info
* name: `configure_gcp_endpoints`
* yaml reference: `Auddia/cicd/actions/configure_gcp_endpoints@<tag>`
* action type: Docker Action

## Description
This is a custom action used for deploying updated api definitions to gcp endpoints.

NOTE: This action assumes that you have setup the gcloud sdk with this [action](../setup_gcloud/README.md) 

### Tags
This action is available on tags `v0` and above

### Action Steps
1. Deploy new/updated endpoints configuration/definition (i.e. changes to the `openapi.yaml`) to GCP endpoints. 
2. Build a new image for the gateway proxy to endpoints and upload it to container registry, so it can be redeployed in cloud run.
3. Redeploy the gateway proxy (i.e. a Cloud Run Service) using the newly generated image
4. Update the default service account privileges, so it can invoke the backend endpoints through the gateway proxy

## Required Setup
To use this action in your repository you need to do the following steps to configure the GCP environment properly.

1. Create the Gateway Proxy for GCP endpoints 
   1. Create Cloud Run Service by deploying ESPv2 container:
```bash
$ gcloud run deploy <API_NAME>-endpoints-cloudrun-service \
  --image="gcr.io/endpoints-release/endpoints-runtime-serverless:2" \
  --allow-unauthenticated \
  --platform managed \
  --project <GCP_PROJECT> \
  --region us-central1
```

2. Map the custom subdomain to the desired backend service in cloud run.
   1. Go to the GCP cloud console. 
   2. First click on to `Cloud Run` 
   3. Then click `Manage Custom Domains` in the top banner 
   4. Add the mapping of api service to the desired domain name.
      1. **NOTE:** Make sure the domain is verified in `Cloud DNS`

3. Run the `configure_gcp_endpoints` action.

### Input Arguments

##### `gcp_project`
* **Description**: The GCP project name
* `type`: `string`
* `required`: `true`

##### `api_subdomain`
* **Description**: The subdomain of the api being deployed
* `type`: `string`
* `required`: `true`

##### `api_name`
* **Description**: Name of the api
* `type`: `string`
* `required`: `true`

##### `endpoints_service_name`
* **Description**: Name of the GCP endpoints service name 
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

```yaml
jobs:
  example_job:
    name: Configure GCP Enpoints Example
    runs-on: ubuntu-latest
    steps:
      - name: GCloud SDK Setup
        uses: Auddia/cicd/actions/setup_gcloud@<tag>
        with:
          gcp_credentials: '${{ secrets.GCP_CREDEENTIALS }}'

      - name: Configure Endpoints
        uses: Auddia/cicd/actions/configure_gcp_endpoints@<tag>
        with:
          gcp_project: ${{ inputs.gcp_project }}
          api_subdomain: ${{ inputs.api_subdomain }}
          api_name: ${{ inputs.api_name }}
          endpoints_service_name: ${{ inputs.endpoints_service_name }}
          default_service_account: ${{ inputs.default_service_account }}
          openapi_yaml: ${{ inputs.openapi_yaml }}
```

### Additonal Usage
* [Tests](../../.github/workflows/test.action.configure_gcp_endpoints.yml)
* [Reuseable Workflow OpenAPI Update](../../.github/workflows/openapi_update.yml)
* [OpenAPI Update Deployment](https://github.com/Auddia/vodacast-functions/blob/staging/.github/workflows/deployments.yml#L7)
    * Note this is call to the reusable workflow from [above](../../.github/workflows/openapi_update.yml), but it is still an example of how to configure the `configure_gcp_endpoints` action.