# Openapi Update Workflow
This workflow generates an openapi configuration and deploys/redeploys GCP endpoints. Make sure to review the actions below to configure your project properly. 

* GCloud SDK setup action: [setup_gcloud](../../actions/setup_gcloud/README.md)
* Openapi config generation action: [compile_openapi action](../../actions/compile_openapi/README.md)
* GCP Endpoints deployment action: [configure_gcp_endpoints action](../../actions/configure_gcp_endpoints/README.md)

### Tags
This action is available on tags `v0` and above.


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

##### `openapi_dir`
* **Description**: The directory location of all the openapi templates and configurations
* `type`: `string`
* `default`: `./`

##### `template`
* **Description**: The name of the template yaml file
* `type`: `string`
* `default`: `template.yaml`

##### `outfile`
* **Description**: The name of the outputted Open API file.
* `type`: `string`
* `default`: `openapi.yaml`

##### `environment_key`
* **Description**: Key in the template to replace with the environment value.
* `type`: `string`
* `default`: `<environment>`

##### `environment_value`
* **Description**: Value that will replace the environment key in the template.
* `type`: `string`
* `default`: `production`


### Secrets

##### `gcp_credentials`
* **Description**: The json api key from Google for the desired service account that will be issuing the commands from the `gcloud` cli.
* References the repo's available secrets and the GitHub group's (i.e. `Auddia`) available secrets
* If the needed credentials secret doesn't exist, and you need to add one follow this [guide](https://cloud.google.com/docs/authentication/getting-started#create-service-account-console) to generate the json value that you will assign the secret. NOTE: You need admin privileges to add a secret to a repo or group


### Example Usage
```yaml
on:
  push:
    branches:
      - staging
      - production

jobs:
  discovery_api_update_staging:
    name: 'Openapi Update Staging Deployment'
    if: github.ref == 'refs/heads/staging'
    uses: Auddia/cicd/.github/workflows/openapi_update.yml@<tag>
    with:
      gcp_project: vodacast-staging
      api_subdomain: discovery.vodacast-staging.auddia.services
      api_name: discovery-api
      endpoints_service_name: discovery-endpoints-cloudrun-service
      default_service_account: 842445588503-compute@developer.gserviceaccount.com
      openapi_dir: ./api/data/openapi
      environment_value: staging
    secrets:
      gcp_credentials: ${{ secrets.VODACAST_STAGING_GCP_CREDENTIALS }}

  discovery_api_update_production:
    name: 'Openapi Update Production Deployment'
    if: github.ref == 'refs/heads/production'
    uses: Auddia/cicd/.github/workflows/openapi_update.yml@<tag>
    with:
      gcp_project: vodacast
      api_subdomain: discovery.vodacast.auddia.services
      api_name: discovery-api
      endpoints_service_name: discovery-endpoints-cloudrun-service
      default_service_account: 186761483508-compute@developer.gserviceaccount.com
      openapi_dir: ./api/data/openapi
      environment_value: production
    secrets:
      gcp_credentials: ${{ secrets.VODACAST_GCP_CREDENTIALS }}
```

### Additional Usage
* [Tests](FILL IN)