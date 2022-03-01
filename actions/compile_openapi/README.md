# Githut Action

## Important Info
* name: `compile_openappi`
* yaml reference: `Auddia/cicd/actions/compile_openapi@main@<tag>`
* action type: Docker Action

## Required Setup
To use this action in your repository you need to do the following to setup the needed templating structure.

1. Create a directory to store all the open api data/definitions. Make a note of this dir because it will be the value used for the `opeanapi_dir` argument to the action.
2. Create a `template.yaml` file 
#### Example template.yaml
```yaml
swagger: "2.0"
info:
  title:
    $ref: './<environment>/config.yaml#/info/title'
  description:
    $ref: './<environment>/config.yaml#/info/description'
  version:
    $ref: './<environment>/config.yaml#/versions/api-version'
schemes:
  - https
produces:
  - application/json

host:
  $ref: './<environment>/config.yaml#/environment/host'
x-google-endpoints:
  $ref: './<environment>/config.yaml#/environment/x-google-endpoints'
x-google-backend:
  $ref: './<environment>/config.yaml#/environment/x-google-backend'

securityDefinitions:
  # This section configures basic authentication with an API key.
  api_key:
    type: "apiKey"
    name: "key"
    in: "query"
security:
  - api_key: [ ]

paths:
  $ref: './common/endpoints.yaml#/paths'
```
3. Utilize a directory hierarchy to control you [yaml references](https://github.com/OAI/OpenAPI-Specification/blob/main/versions/2.0.md#reference-object) in the template above. 
4. Utilize the `environment_key` and `environment_value` inputs to dynamically update the imports in the template. This is primarily used to switch the environment for separate build configurations

[Example Structure](https://github.com/Auddia/vodacast-functions/tree/staging/api/data/openapi)

## Description
This action utilizes the [swagger-cli](https://github.com/APIDevTools/swagger-cli) and the templating structure outlined above to automatically build an `openapi.yaml` file for tools that
need the openapi configuration (i.e. [`conficure_ gcp_endpoints`](../configure_gcp_endpoints/README.md)). The configuration generated in this action is available to other actions/steps in the same job.

#### openapi made available in the following step/action types
* [Composite Actions](https://docs.github.com/en/actions/creating-actions/creating-a-composite-action) 
  * The data maybe in a wierd (i.e. non-default directory but it is there) 
* [Docker Actions](https://docs.github.com/en/actions/creating-actions/creating-a-docker-container-action)
    * Tested image: [`google/cloud-sdk`](https://hub.docker.com/r/google/cloud-sdk/)
    * The data maybe in a wierd (i.e. non-default directory but it is there)
* Other action types not tested

### Input Arguments

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

## Example Usage

```
jobs:
  example job:
    name: Configure GCP Enpoints Example
    runs-on: ubuntu-latest
    steps:
      - name: Compile OpenAPI YAML File
        uses: Auddia/cicd/actions/compile_openapi@<tag>
        with:
          openapi_dir: ${{ inputs.openapi_dir }}
          template: ${{ inputs.template }}
          outfile: ${{ inputs.openapi_yaml }}
          environment_key: ${{ inputs.environment_key }}
          environment_value: ${{ inputs.environment_value }}
```

### Additonal Usage
* [Reuseable Workflow OpenAPI Update](../../.github/workflows/openapi_update.yml)
* [OpenAPI Update Deployment](https://github.com/Auddia/vodacast-functions/blob/staging/.github/workflows/deployments.yml#L7)
    * Note this is call to the reusable workflow from [above](../../.github/workflows/openapi_update.yml), but it is still an example of how to configure the `configure_gcp_endpoints` action.
