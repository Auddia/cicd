# Github CICD 
This repository stores a collections of common github actions and workflows for all projects to reuse for common automation workflows (deployment, testing, building, pubilishing, etc). 

## Table Of Contents
* [Github Actions Documentation](https://docs.github.com/en/actions)
* [Workflows](#workflows)
* [Actions](#actions)
* [Release Info](#releases)
  * [`v0`](#v0)
  * [`v01`](#v01)
  * [`v02`](#v02)

## Workflows
Workflows define a job or a group of jobs that can be run in parallel or in some defined order. All the 
[reuseable workflows](https://docs.github.com/en/actions/using-workflows/reusing-workflows) are stored in the `.github/workflows` directory.

* [Github Workflow Definition](https://docs.github.com/en/actions/learn-github-actions/understanding-github-actions#workflows)

### Custom Workflows
* [Openapi Update Workflow](./docs/workflows/openapi_update.md)
* [Cloud Run API Deployment](./docs/workflows/cloud_run_api_deployment.md)


## Actions
Actions define a group of common steps that reoccur across many jobs and workflows. All the 
[custom actions](https://docs.github.com/en/actions/creating-actions/about-custom-actions) are stored in the `actions` directory.

* [Github Action Definition](https://docs.github.com/en/actions/learn-github-actions/understanding-github-actions#actions)

### Custom Actions
* [Build and publish docker image action docs](./actions/build_and_publish_image/README.md)
* [Compile Openapi action docs](./actions/compile_openapi/README.md)
* [Configure GCP endpoints action docs](./actions/configure_gcp_endpoints/README.md)
* [Decrypt KMS secrets action docs](./actions/decrypt_kms_secrets/README.md)
* [Setup gcloud action docs](./actions/setup_gcloud/README.md)

## Releases

### `v0`
* [Official Release](https://github.com/Auddia/cicd/releases/tag/v0)
#### New
* [compile_openapi action docs](./actions/compile_openapi/README.md)
* [configure_gcp_endpoints action docs](./actions/configure_gcp_endpoints/README.md)
* [setup_gcloud action docs](./actions/setup_gcloud/README.md)
* [openapi_update Workflow](./docs/workflows/openapi_update.md)

#### Available Actions
* [compile_openapi action docs](./actions/compile_openapi/README.md)
* [configure_gcp_endpoints action docs](./actions/configure_gcp_endpoints/README.md)
* [setup_gcloud action docs](./actions/setup_gcloud/README.md)

#### Available Workflows
* [openapi_update Workflow](./docs/workflows/openapi_update.md)


### `v01`
* [Official Release](https://github.com/Auddia/cicd/releases/tag/v01)
#### New
* [build_and_publish_image action docs](./actions/build_and_publish_image/README.md)
  * [cloud_run_api_deployment_workflow](./docs/workflows/cloud_run_api_deployment.md)
#### Updated
* [setup_gcloud action docs](./actions/setup_gcloud/README.md)
  * Added in support to get GCP secrets

#### Available Actions
* [compile_openapi action docs](./actions/compile_openapi/README.md)
* [configure_gcp_endpoints action docs](./actions/configure_gcp_endpoints/README.md)
* [setup_gcloud action docs](./actions/setup_gcloud/README.md)
* [build_and_publish_image action docs](./actions/build_and_publish_image/README.md)

#### Available Workflows
* [openapi_update Workflow](./docs/workflows/openapi_update.md)
* [cloud_run_api_deployment_workflow](./docs/workflows/cloud_run_api_deployment.md)
  

### `v02`
COMING SOON
* [Official Release](https://github.com/Auddia/cicd/releases/tag/v02)
#### New
* [decrypt_kms_secrets action docs](./actions/decrypt_kms_secrets/README.md)

#### Updated
* [cloud_run_api_deployment_workflow](./docs/workflows/cloud_run_api_deployment.md) 
  * Added in support for the decryption of encrypted data using kms keys

#### Available Actions
* [compile_openapi action docs](./actions/compile_openapi/README.md)
* [configure_gcp_endpoints action docs](./actions/configure_gcp_endpoints/README.md)
* [setup_gcloud action docs](./actions/setup_gcloud/README.md)
* [build_and_publish_image action docs](./actions/build_and_publish_image/README.md)
* [decrypt_kms_secrets action docs](./actions/decrypt_kms_secrets/README.md)
#### Available Workflows
* [openapi_update Workflow](./docs/workflows/openapi_update.md)
* [cloud_run_api_deployment_workflow](./docs/workflows/cloud_run_api_deployment.md)


