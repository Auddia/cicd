# Github Action

## Important Info
* name: `build_and_publish_image`
* yaml reference: `Auddia/cicd/actions/build_and_publish_image@<tag>`
* action type: Composite Action

## Description
This action builds and publishes a docker image.

Can publish to:
* GCP's Container Registry

### Tags
This action is available on tags `v01` and above

## Required Setup
To use this action in your repository you need to do the following to setup.
1. Have a dockerfile defining the applications deployment environment.
2. If you are publishing to GCP's container registry make sure to run the [setup_gcloud action](../setup_gcloud/README.md) before using this action in a job.

### Input Arguments

##### `tag`
* **Description**: Image tag
* `type`: `string`
* `required`
* **NOTE**: If your tag contains `gcr.io` the `gcloud-sdk` needs to be configured using this [action](../setup_gcloud/README.md). This is shown in the example usage section.

##### `dockerfile`
* **Description**: Location of the dockerfile
* `type`: `string`
* `required`

##### `build_context`
* **Description**: Location for docker's build context
* `type`: `string`
* `required`: `false`
* `default`: `.`

##### `build_args`
* **Description**: Additional agruments to pass to docker build
* `type`: `string`
* `required`: `false`
* `default`: `''`
* Syntax
```yaml
build_args: |
    --disable-content-trust \
    --pull \
```

##### `push_args`
* **Description**: Additional arguments to pass to docker push
* `type`: `string`
* `required`: `false`
* `default`: `''`
* Syntax
```yaml
push_args: |
    --disable-content-trust \
    --quiet \
```

##### `gcp_secrets`
* **Description**: Secrets from GCP that you want available in the docker container
* `type`: `string`
* `required`: `true`
* Uses the `outputs.secrets` from the [setup_gcloud](../setup_gcloud/README.md) action

## Example Usage

```yaml
jobs:
  example_image:
    name: Publish image to Docker
    runs-on: ubuntu-latest
    steps:  
      - name: Build and Publish Docker Image
        uses: 'Auddia/cicd/actions/build_and_publish_image@<tag>'
        with:
          tag: '<tag>'
          dockerfile: ./api/Dockerfile
          build_args: |
            CONNECTION_STR: 10.63.224.44
            DB_USER: discovery_api_server
            MIN_CONNECTIONS: 10
            MAX_CONNECTIONS: 15
  
  example_image_no_secrets:
    name: Publish image to GCP
    runs-on: ubuntu-latest
    steps:
      - name: Setup GCloud SDK Environment
        uses: Auddia/cicd/actions/setup_gcloud@<tag>
        with:
          gcp_credentials: '${{ inputs.gcp_credentials }}'
    
      - name: Build and Publish Docker Image
        uses: 'Auddia/cicd/actions/build_and_publish_image@<tag>'
        with:
          tag: 'gcr.io/${{ gcp_project }}/discovery-api:${{ github.sha }}'
          dockerfile: ./api/Dockerfile
          build_args: |
            CONNECTION_STR: 10.63.224.44
            DB_USER: discovery_api_server
            MIN_CONNECTIONS: 10
            MAX_CONNECTIONS: 15

  example_image_with_restricted_secrets:
    name: Publish image to GCP with only a part of the secrets retrieved
    runs-on: ubuntu-latest
    steps:
      - name: Setup GCloud SDK Environment
        id: gcp
        uses: 'Auddia/cicd/actions/setup_gcloud@<tag>'
        with:
          gcp_credentials: '${{ secrets.VODACAST_STAGING_GCP_CREDENTIALS }}'
          gcp_secrets: |
            DB_PWD: projects/vodacast-staging/secrets/vodacast-postgres-password
            OTHER: projects/vodacast-staging/secrets/other

      - name: Build and Publish Docker Image
        uses: 'Auddia/cicd/actions/build_and_publish_image@<tag>'
        with:
          tag: 'gcr.io/${{ gcp_project }}/discovery-api:${{ github.sha }}'
          dockerfile: ./api/Dockerfile
          build_config: |
            CONNECTION_STR: 10.30.192.3
            DB_USER: postgres
            MIN_CONNECTIONS: 10
            MAX_CONNECTIONS: 15
            DB_PWD: ${{ fromJson(steps.gcp.outputs.secrets).DB_PWD }}

  example_image_with_all_secrets:
    name: Publish Image with all the request secrets
    runs-on: ubuntu-latest
    steps:
      - name: Setup GCloud SDK Environment
        id: gcp
        uses: 'Auddia/cicd/actions/setup_gcloud@<tag>'
        with:
          gcp_credentials: '${{ secrets.VODACAST_STAGING_GCP_CREDENTIALS }}'
          gcp_secrets: |
            DB_PWD: projects/vodacast-staging/secrets/vodacast-postgres-password
            OTHER: projects/vodacast-staging/secrets/other
            
      # All secrets from the gcp step will be available in the build image as --build-args
      - name: Build and Publish Docker Image
        uses: 'Auddia/cicd/actions/build_and_publish_image@<tag>'
        with:
          tag: 'gcr.io/${{ gcp_project }}/discovery-api:${{ github.sha }}'
          dockerfile: ./api/Dockerfile
          gcp_secrets: ${{ steps.gcp.outputs.secrets }}
          build_config: |
            CONNECTION_STR: 10.30.192.3
            DB_USER: postgres
            MIN_CONNECTIONS: 10
            MAX_CONNECTIONS: 15
```

### Additonal Usage
* [Tests](../../.github/workflows/test.action.build_and_publish_image.yml)
* [Cloud Run API Deployment](../../.github/workflows/cloud_run_api_deployment.yml)
