# Githut Action

## Important Info
* name: `configure_ssh`
* yaml reference: `Auddia/cicd/actions/configure_ssh@<tag>`
* action type: Composite

## Description
This reusable action takes a private ssh key and configures your job to use ssh

### Tags
This action is available on tags `v03` and above

#### ssh made available in the following step/action types
* [Composite Actions](https://docs.github.com/en/actions/creating-actions/creating-a-composite-action) 
  * The code maybe in a weird (i.e. non-default directory but it is there)
* [Docker Actions](https://docs.github.com/en/actions/creating-actions/creating-a-docker-container-action)
* Other action types not tested


### Input Arguments

##### `private_ssh_key`
* **Description**: Github secret storing the ssh private key
* `type`: `string`
* `required`

## Example Usage

```yaml
jobs:
  example_job:
    name: 'An example job that uses the ssh'
    runs-on: ubuntu-latest
    steps:
      - name: 'Configure ssh'
        uses: Auddia/cicd/actions/configure_ssh@<tag>
        with:
          gcp_credentials: ${{ secrets.GCP_CREDEENTIALS }}

      - name: 'example ssh test'
        run: git clone git@github.com:Auddia/cloudsql.git
```

### Additonal Usage
* [Tests](../../.github/workflows/test.action.setup_gcloud.yml)
* [Reuseable Workflow OpenAPI Update](../../.github/workflows/openapi_update.yml)
* [Reuseable Workflow Cloud Run API Deployment](../../.github/workflows/cloud_run_api_deployment.yml)
* [Dynamic Usage of Secrets Usage](../build_and_publish_image/action.yaml)