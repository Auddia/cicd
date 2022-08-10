# Cloud Run API Deployment Workflow
This workflow build and publishes a docker image to GCP's docker registry and then deploys that container as an application under GCP's cloud run. Make sure to review the actions below to configure your project properly. 

* GCloud SDK setup action: [setup_gcloud](../../actions/setup_gcloud/README.md)
* (Optional Step) Decrypt KMS secrets action [decrypt_kms_secrets](../../actions/decrypt_kms_secrets/README.md)
* Build and publish Docker image action: [build_and_publish_image](../../actions/build_and_publish_image/README.md)
* (Optional Step) Setting up deploy key from private repo interaction: [Deploy Key Setup](../DEPLOY_KEYS.md)

### Tags
This action is available on tags `v01` and above.

### Input Arguments

##### `gcp_project`
* **Description**: The GCP project name
* `type`: `string`
* `required`: `true`

##### `gcp_secrets`
* **Description**: Secrets from GCP that you want available in the docker container
* `type`: `string`
* `required`: `false`
* Uses the `outputs.secrets` from the [setup_gcloud](../../actions/setup_gcloud/README.md) action
* Although the [setup_gcloud](../../actions/setup_gcloud/README.md) action allows users to restrict access to the secrets retrieved this action only supports all 
  secrets being passed to the api being built. The restriction of secrets can not be supported until github allows a more nimble way of accessing [github contexts](https://docs.github.com/en/actions/learn-github-actions/contexts#github-context) dynamically. 
  Here is a [stackoverflow article](https://stackoverflow.com/questions/61255989/dynamically-retrieve-github-actions-secret) describing the issue.
* Syntax
```yaml
gcp_secrets: |
  DB_PASSWORD: projects/vodacast-staging/secrets/vodacast-postgres-password
```

##### `key_ring`
* **Description**: The GCP KMS keyring that the keys are retrieved from
* `type`: `string`
* `default`: `''`

##### `decrypt_info`
* **Description**: A list of decryption requests in the format (`ciphertext : key : plaintext`)
* `type`: `string`
* `default`: `''`
* NOTE: The `plaintext` input is generated in this step and the cipher text exists in the environment. Additionally, the `key` requested from KMS must be the key that was used to create the `ciphertext`
* Syntax
```yaml
decrypt_info: |
    test_key.key.enc : test_key : test_key.key
    test_key_two.key.enc : test_key : test_two_key.key
```

##### `input_dir`
* **Description**: The location where the encrypted data is stored
* `type`: `string`
* `default`: `.`

##### `output_dir`
* **Description**: The location to store the decrypted data
* `type`: `string`
* `default`: `.`


##### `api_name`
* **Description**: Name of the api
* `type`: `string`
* `required`: true

##### `dockerfile`
* **Description**: Location of the dockerfile
* `type`: `string`
* `default`: `./Dockerfile`

##### `build_config`
* **Description**: A list of environment variables to pass as build args to the build step
* `type`: `string`
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
* `default`: `.`

##### `build_args`
* **Description**: Additional agruments to pass to docker build
* `type`: `string`
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
* `default`: `''`
* Syntax
```yaml
push_args: |
    --disable-content-trust \
    --quiet \
```

##### `enable_ssh`
* **Description**: A flag to allow users to toggle on ssh configuration
* `type`: `boolean`
* `required`: `false`
* `default`: `false`
* **NOTE**: This flag makes ssh available to other actions 
* If you wish to make ssh available within a docker container refer to the [build_and_publish_image](../../actions/build_and_publish_image/action.yaml) action
* If you are enabling ssh for pip installing private git repos in a docker container make sure to do the following
  * set the `DOCKER_BUILDKIT` environment variable to 1
  * When using pip in the docker file use `RUN --mount=type=ssh`

##### `deploy_args`
* **Description**: Additional arguments to pass to `gcloud beta run deploy`
* `type`: `string`
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
* If the needed credentials secret doesn't exist, and you need to add one follow this [guide](https://cloud.google.com/docs/authentication/getting-started#create-service-account-console) to generate the json value that you will assign the secret. NOTE: You need admin privileges to add a secret to a repo or group

##### `ssh_private_keys`
* **Description**: A list of github secret containing a private SSH key
* [How to generate a new ssh key for github](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent) 
* Reference the [Deploy Key Setup](../DEPLOY_KEYS.md) guide if you are using SSH keys for github repo interaction
* Syntax
```yaml
ssh_private_keys: |
  ${{ secrets.REPO_ONE_DEPLOY_KEY }}
  ${{ secrets.REPO_TWO_DEPLOY_KEY }}
```

[comment]: <> (TODO: UPDATE)
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
    name: '(Staging) Discovery API Deployment'
    if: github.ref == 'refs/heads/staging'
    uses: Auddia/cicd/.github/workflows/cloud_run_api_deployment.yml@<tag>
    with:
      gcp_project: vodacast-staging
      api_name: discovery-api
      dockerfile: ./api/Dockerfile
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
    name: '(Production) Discovery API Deployment'
    if: github.ref == 'refs/heads/production'
    uses: Auddia/cicd/.github/workflows/cloud_run_api_deployment.yml@<tag>
    with:
      gcp_project: vodacast
      api_name: discovery-api
      dockerfile: ./api/Dockerfile
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
* [Tests](FILL IN)
