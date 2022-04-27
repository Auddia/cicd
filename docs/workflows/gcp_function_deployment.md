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

##### `runtime`
* **Description**: The GCP function runtime 
* `type`: `string`
* `required`: `true`

##### `entry_point`
* **Description**: The function entry point
* `type`: `string`
* `required`: `true`

##### `environment_variables`
* **Description**: List of environment variables to pass to set in the function
* `type`: `string`
* `required`: `false`
* `default`: `''`
* Syntax
```yaml
environment_variables: |
  VARIABLE_NAME: VALUE
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