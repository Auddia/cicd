# Github CICD 
This repository stores a collections of common github actions and workflows for all projects to reuse for common automation workflows (deployment, testing, building, pubilishing, etc). 

## NOTE:
Make sure to refer to the docs for the specific release, tag or branch to have the most accurate documentation for the version you are using.

## Table Of Contents
* [Github Actions Documentation](https://docs.github.com/en/actions)
* [Workflows](#workflows)
* [Actions](#actions)
* [Release Info](#releases)
  * [`Prerelease v0`](./docs/releases/prerelease.v0.md)
  * [`Prerelease v01`](./docs/releases/prerelease.v01.md)
  * [`Prerelease v02`](./docs/releases/prerelease.v02.md)
  * [`Prerelease v03`](./docs/releases/prerelease.v03.md)
  * [`Prerelease v04`](./docs/releases/prerelease.v04.md)
  * [`v1`](./docs/releases/v1.md)
  * [`v1.1`](./docs/releases/v1.1.md)
  * [`v1.2`](./docs/releases/v1.2.md)
  * [`v1.3`](./docs/releases/v1.3.md)
  * [`v1.4`](./docs/releases/v1.4.md)

* [Action Items](#action-items)

## Workflows
Workflows define a job or a group of jobs that can be run in parallel or in some defined order. All the 
[reuseable workflows](https://docs.github.com/en/actions/using-workflows/reusing-workflows) are stored in the `.github/workflows` directory.

* [Github Workflow Definition](https://docs.github.com/en/actions/learn-github-actions/understanding-github-actions#workflows)

### Custom Workflows
* [Openapi Update](./docs/workflows/openapi_update.md)
* [Cloud Run API Deployment](./docs/workflows/cloud_run_api_deployment.md)
* [python_test Workflow](./docs/workflows/python_test.md)
* [gcp_function_deployment Workflow](./docs/workflows/gcp_function_deployment.md)


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
  * [`Prerelease v0`](https://github.com/Auddia/cicd/releases/tag/v0)
  * [`Prerelease v01`](https://github.com/Auddia/cicd/releases/tag/v01)
  * [`Prerelease v02`](https://github.com/Auddia/cicd/releases/tag/v02)
  * [`Prerelease v03`](https://github.com/Auddia/cicd/releases/tag/v03)
  * [`Prerelease v04`](https://github.com/Auddia/cicd/releases/tag/v04)
  * [`v1`](https://github.com/Auddia/cicd/releases/tag/v1)
  * [`v1.1`](https://github.com/Auddia/cicd/releases/tag/v1.1)
  * [`v1.2`](https://github.com/Auddia/cicd/releases/tag/v1.2)
  * [`v1.3`](https://github.com/Auddia/cicd/releases/tag/v1.3)
  * [`v1.4`](https://github.com/Auddia/cicd/releases/tag/v1.4)


# Action Items
* How to test commands that deploy to GCP?
  * Need some sort of mocking mechanism or a container that we can deploy in the runner while it is testing
  * Test's where this is involved are marked as TODO.
    * [todo.test.action.configure_gcp_endpoints](./.github/workflows/todo.test.action.configure_gcp_endpoints.yml)
    * [todo.test.workflow.open_api_update](./.github/workflows/todo.test.workflow.open_api_update.yml)
    * [todo.test.workflow.cloud_run_api_deployment](./.github/workflows/todo.test.workflow.cloud_run_api_deployment.yml)
* Error Propagation
  * Needs to be tested
* Release workflow to automate the release project
* Main workflow that updates all tags to main before merging in

