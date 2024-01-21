# Githut Action

## Important Info
* name: `decrypt_kms_secret`
* yaml reference: `Auddia/cicd/actions/decrypt_kms_secret@<tag>`
* action type: Composite

## Description
This reusable action gets all the keys from a specific key ring and uses them to decrypt data for a deployment. The decrypted data
is saved and it is made available to all subsequent actions and steps.

NOTE: This action assumes that you have setup the gcloud sdk with this [action](../setup_gcloud/README.md) 

### Tags
This action is available on tags `v02` and above

#### the decrypted data made available in the following step/action types
* [Composite Actions](https://docs.github.com/en/actions/creating-actions/creating-a-composite-action) 
  * The code maybe in a wierd (i.e. non-default directory but it is there)
* Other action types not tested

### Input Arguments

##### `key_ring`
* **Description**: The GCP KMS keyring that the keys are retrieved from
* `type`: `string`
* `required`

##### `decrypt_info`
* **Description**: A list of decryption requests in the format (`ciphertext : key : plaintext`)
* `type`: `string`
* `required`
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


### Output
The all generated `plaintext` in this step is made available to all subsequent steps and action within the same job. The `plaintest` is located in the `output_dir` specified, and they will have the same name as the `plaintext` from the `decrypt_info` input.

## Example Usage

```yaml
jobs:
  decrypt_key:
    name: 'Decrypt Key'
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
        with:
          ref: ${{ github.ref }}

      - name: GCloud SDK Setup
        uses: ./actions/setup_gcloud
        with:
          gcp_credentials: ${{ github.event.inputs.gcp_secret }}

      - name: 'Get Single KMS File'
        uses: ./actions/decrypt_kms_secrets
        with:
          key_ring: test
          input_dir: ./resources
          output_dir: ./decyphered_data
          decrypt_info: |
            test_key.key.enc : test_key : test_key.key

      - name: 'Validate Keys Were Created'
        shell: bash
        run: |
          source ./scripts/test_functions.sh
          output=$(cat ./decyphered_data/test_key.key)
          expected="Hello World
          "
          strings_equal "$output" "$expected"
```

### Additional Usage
* [Tests](../../.github/workflows/test.action.decrypt_kms_secrets.yml)
* [Reuseable Workflow Cloud Run API Deployment](../../.github/workflows/cloud_run_api_deployment.yml)
