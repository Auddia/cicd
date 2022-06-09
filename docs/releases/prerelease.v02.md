# v02 Release (3/21/2022)
[Official Release](https://github.com/Auddia/cicd/releases/tag/v02)

## New
* [decrypt_kms_secrets action docs](../../actions/decrypt_kms_secrets/README.md)
* test.action.build_and_publish_image.yml
* test.action.compile_open_api.yml
* test.action.decrypt_kms_secrets.yml
* test.action.setup_gcloud.yml
* todo.test.action.configure_gcp_endpoints.yml
* todo.test.workflow.cloud_run_api_deployment.yml
* todo.test.workflow.openapi_update.yml

## Updated
* [cloud_run_api_deployment_workflow](../../docs/workflows/cloud_run_api_deployment.md)
  * **FEATURE**: Added in optional parameter to allow for kms decrpytion in the build process if needed
* [configure_gcp_endpoints action](../../actions/configure_gcp_endpoints/README.md)  
  * **BUG**: Fixed hard coded value error in deployment script
  * **BUG**: Added in error propagation (Needs further testing)
* [openapi_update workflow](../../docs/workflows/openapi_update.md)  
  * **BUG**: Fixed hard coded value error in deployment script
  * **BUG**: Added in error propagation (Needs further testing)

## Available Actions
* [compile_openapi action docs](../../actions/compile_openapi/README.md)
* [configure_gcp_endpoints action docs](../../actions/configure_gcp_endpoints/README.md)
* [setup_gcloud action docs](../../actions/setup_gcloud/README.md)
* [build_and_publish_image action docs](../../actions/build_and_publish_image/README.md)
* [decrypt_kms_secrets action docs](../../actions/decrypt_kms_secrets/README.md)

## Available Workflows
* [openapi_update Workflow](../../docs/workflows/openapi_update.md)
* [cloud_run_api_deployment_workflow](../../docs/workflows/cloud_run_api_deployment.md)