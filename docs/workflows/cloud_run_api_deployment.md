# Cloud Run API Deployment Workflow
This workflow build and publishes a docker image to GCP's docker registry and then deploys that container as an application under GCP's cloud run. Make sure to review the actions below to configure your project properly. 

* GCloud SDK setup action: [setup_gcloud](../../actions/setup_gcloud/README.md)
* Build and publish Docker image action: [build_and_publish_image](../../actions/build_and_publish_image/README.md)

### Input Arguments

##### `gcp_project`
* **Description**: The GCP project name
* `type`: `string`
* `required`: `true`

##### `gcp_secrets`
* **Description**: Secrets from GCP that you want available in the docker container
* `type`: `string`
* `required`: `true`
* Uses the `outputs.secrets` from the [setup_gcloud](../../actions/setup_gcloud/README.md) action
* Although the [setup_gcloud](../../actions/setup_gcloud/README.md) action allows users to restrict access to the secrets retrieved this action only supports all 
  secrets being passed to the api being built. The restriction of secrets can not be supported until github allows a more nimble way of accessing [github contexts](https://docs.github.com/en/actions/learn-github-actions/contexts#github-context) dynamically. 
  Here is a [stackoverflow article](https://stackoverflow.com/questions/61255989/dynamically-retrieve-github-actions-secret) describing the issue.

##### `api_name`
* **Description**: Name of the api
* `type`: `string`
* `required`: `true`

##### `dockerfile`
* **Description**: Location of the dockerfile
* `type`: `string`
* `required`: `false`
* `default`: `./Dockerfile`

##### `build_config`
* **Description**: A list of environment variables to pass as build args to the build step
* `type`: `string`
* `required`: `false`
* `default`: `''`
* Syntax
```yaml
build_config: |
    CONNECTION_STR: 10.30.192.3
    DB_USER: postgres
    MIN_CONNECTIONS: 10
    MAX_CONNECTIONS: 15
```

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

##### `deploy_args`
* **Description**: Additional arguments to pass to `gcloud beta run deploy`
* `type`: `string`
* `required`: `false`
* `default`: `''`
* Syntax
```yaml
deploy_args: |
    --vpc-connector vodacast-staging-default \
    --cpu 2 \
    --min-instances 2 \
    --set-cloudsql-instances vodacast-staging:us-central1:vodacast \
```

### Secrets

##### `gcp_credentials`
* **Description**: A github secret containing the json api key from google for the desired service account that will be issuing the commands from the `gcloud` cli.
* References the repo's available secrets and the github group's (i.e. `Auddia`) available secrets
* If the needed credentials secret doesnt exist and you need to add one follow this [guide](https://cloud.google.com/docs/authentication/getting-started#create-service-account-console) to generate the json value that you will assign the secret. NOTE: You need admin privileges to add a secret to a repo or group


### Example Usage
```yaml
on:
  push:
    branches:
      - staging
      - production
    paths:
      - 'api/**'
      - '!api/data/openapi/**'


jobs:
  discovery_api_staging:
    name: (Staging) Discovery API Deployment
    if: github.ref == 'refs/heads/staging'
    uses: Auddia/cicd/.github/workflows/cloud_run_api_deployment.yml@<tag>
    with:
      gcp_project: 'vodacast-staging'
      api_name: discovery-api
      dockerfile: './api/Dockerfile'
      gcp_secrets: |
        DB_PWD: projects/vodacast-staging/secrets/vodacast-postgres-password
      build_config: |
        CONNECTION_STR: 10.30.192.3
        DB_USER: postgres
        MIN_CONNECTIONS: 10
        MAX_CONNECTIONS: 15
      deploy_args: |
        --vpc-connector vodacast-staging-default \
        --cpu 2 \
        --min-instances 2 \
        --set-cloudsql-instances vodacast-staging:us-central1:vodacast \
    secrets:
      gcp_credentials: ${{ secrets.VODACAST_STAGING_GCP_CREDENTIALS }}

  discovery_api_production:
    name: (Production) Discovery API Deployment
    if: github.ref == 'refs/heads/production'
    uses: Auddia/cicd/.github/workflows/cloud_run_api_deployment.yml@<tag>
    with:
      gcp_project: 'vodacast'
      api_name: discovery-api
      dockerfile: './api/Dockerfile'
      gcp_secrets: |
        DB_PWD: projects/vodacast/secrets/discovery_db-discovery_api_server-password
      build_args: |
        CONNECTION_STR: 10.63.224.44
        DB_USER: discovery_api_server
        MIN_CONNECTIONS: 10
        MAX_CONNECTIONS: 15
      deploy_args: |
        --vpc-connector vodacast-staging-default \
        --cpu 2 \
        --min-instances 2 \
        --set-cloudsql-instances vodacast-staging:us-central1:vodacast \
    secrets:
      gcp_credentials: ${{ secrets.VODACAST_GCP_CREDENTIALS }}

```

### Additional Usage
* [API Deployment](FILL IN)