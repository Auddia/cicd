# GCP Function Deployment Workflow
This workflow deploys a GCP function.

### Tags
This action is available on tags `v04` and above.

### Input Arguments
##### `gcp_project`
* **Description**: The GCP project name
* `type`: `string`
* `required`: `true`

##### `service_account`
* **Description**: The GCP service account to run the function under
* `type`: `string`
* `required`: `true`

##### `function_name`
* **Description**: The name of the GCP function
* `type`: `string`
* `required`: `true`

##### `entry_point`
* **Description**: The function entry point
* `type`: `string`
* `required`: `true`

##### `runtime`
* **Description**: The GCP function runtime 
* `type`: `string`
* `required`: `false`
* `default`: `python37`

##### `gcp_secrets`
* **Description**: Secrets from GCP that you want available in the docker container
* `type`: `string`
* `required`: `fasle`
* Uses the `outputs.secrets` from the [setup_gcloud](../../actions/setup_gcloud/README.md) action
* Although the [setup_gcloud](../../actions/setup_gcloud/README.md) action allows users to restrict access to the secrets retrieved this action only supports all 
  secrets being passed to the api being built. The restriction of secrets can not be supported until github allows a more nimble way of accessing [github contexts](https://docs.github.com/en/actions/learn-github-actions/contexts#github-context) dynamically. 
  Here is a [stackoverflow article](https://stackoverflow.com/questions/61255989/dynamically-retrieve-github-actions-secret) describing the issue.
* Syntax
```yaml
gcp_secrets: |
  DB_PASSWORD: projects/vodacast-staging/secrets/vodacast-postgres-password
```

##### `environment_variables`
* **Description**: List of environment variables to pass to set in the function
* `type`: `string`
* `required`: `false`
* `default`: `''`
* Syntax
```yaml
environment_variables: |
  VARIABLE_NAME: VALUE,
  VARIABLE_TWO: VALUE
```

##### `function_dir`
* **Description**: Location of the directory containing the GCP function code
* `type`: `string`
* `required`: `false`
* `default`: `.`

##### `extra_function_args`
* **Description**: Extra args to pass to the GCP function deploy command
* `type`: `string`
* `required`: `false`
* `default`: `''`
* Syntax
```yaml
extra_function_args: |
  --timeout 540 \
  --max-instances 1600 \
  --vpc-connector vodacast-default \
```

### Secrets
##### `gcp_credentials`
* **Description**: A github secret containing the json api key from google for the desired service account that will be issuing the commands from the `gcloud` cli.
* References the repo's available secrets and the github group's (i.e. `Auddia`) available secrets
* If the needed credentials secret doesn't exist, and you need to add one follow this [guide](https://cloud.google.com/docs/authentication/getting-started#create-service-account-console) to generate the json value that you will assign the secret. NOTE: You need admin privileges to add a secret to a repo or group


### Example Usage
```yaml
```

### Additional Usage
* [Tests](FILL IN)