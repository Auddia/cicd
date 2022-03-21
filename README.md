# Github CICD 
This repository stores a collections of common github actions and workflows for all projects to reuse for common automation workflows (deployment, testing, building, pubilishing, etc). 

## NOTE:
Make sure to refer to the docs for the specific release, tag or branch to have the most accurate documentation for the version you are using.

## Table Of Contents
* [Github Actions Documentation](https://docs.github.com/en/actions)
* [Workflows](#workflows)
* [Actions](#actions)
* [Release Info](#releases)
  * [`v0`](./docs/releases/v0.md)
  * [`v01`](./docs/releases/v01.md)
  * [`v02`](./docs/releases/v02.md)
* [Action Items]()

## Workflows
Workflows define a job or a group of jobs that can be run in parallel or in some defined order. All the 
[reuseable workflows](https://docs.github.com/en/actions/using-workflows/reusing-workflows) are stored in the `.github/workflows` directory.

* [Github Workflow Definition](https://docs.github.com/en/actions/learn-github-actions/understanding-github-actions#workflows)

### Custom Workflows
* [Openapi Update](./docs/workflows/openapi_update.md)
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
For more information on each release view the official release docs. For even more information refer to the docs in the `source_code.zip` or the github `tag` for the specific release.
  * [`v0`](https://github.com/Auddia/cicd/releases/tag/v0)
  * [`v01`](https://github.com/Auddia/cicd/releases/tag/v01)
  * [`v02`](https://github.com/Auddia/cicd/releases/tag/v02)


# Action Items
* How to test commands that deploy to GCP?
  * Need some sort of mocking mechanism or a container that we can deploy in the runner while it is testing
  * Test's where this is involved are marked as TODO.
    * [todo.test.action.configure_gcp_endpoints](./.github/workflows/todo.test.action.configure_gcp_endpoints.yml)
    * [todo.test.workflow.open_api_update](./.github/workflows/todo.test.workflow.open_api_update.yml)
    * [todo.test.workflow.cloud_run_api_deployment](./.github/workflows/todo.test.workflow.cloud_run_api_deployment.yml)
* Error Propagation
  * Needs to be tested

