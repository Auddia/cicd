# Github CICD 
This repository stores a collections of common github actions and workflows for all projects to reuse for common automation workflows (deployment, testing, building, pubilishing, etc). 

## Table Of Contents
* [Github Actions Documentation](https://docs.github.com/en/actions)


[comment]: <> (* [Workflows]&#40;#workflows&#41;)

[comment]: <> (* [Actions]&#40;#actions&#41;)

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
* [Setup gcloud action docs](./actions/setup_gcloud/README.md)
