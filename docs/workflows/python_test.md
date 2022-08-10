# Python Test Workflow
This workflow runs all the needed tests for a python app.

* (Optional Step) Setting up deploy key from private repo interaction: [Deploy Key Setup](../DEPLOY_KEYS.md)

### Tags
This action is available on tags `v04` and above.


### Input Arguments

##### `python_versions`
* **Description**: A json string of the versions desired (e.g. `"[\"3.7\", \"3.8\"]"`)
* `type`: `string`
* `required`: `true`

##### `test_dir`
* **Description**: Directory containing all the test files to be run
* `type`: `string`
* `required`: `true`

##### `test_setup`
* **Description**: A flag to control whether we use the default requirements.txt or a setup.py 
* `type`: `boolean`
* `required`: `false`
* `default`: `true`

##### `enable_ssh`
* **Description**: A flag to allow users to toggle on ssh configuration
* `type`: `boolean`
* `required`: `false`
* `default`: `false`
* **NOTE**: This flag makes ssh available to other actions

##### `setup_dir`
* **Description**: The directory the setup.py is located in 
* `type`: `string`
* `required`: `false`
* `default`: `.`

##### `requirements`
* **Description**: The location of the requirements.txt
* `type`: `string`
* `required`: `false`
* `default`: `./requirements.txt`

### Secrets

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

### Example Usage
```yaml
name: '[Workflow Test] python_test'

on: 
  workflow_dispatch:

jobs:
  test_setup:
    name: 'Setup Test'
    uses: Auddia/cicd/.github/workflows/python_test.yml
    with:
      python_versions: "[\"3.7\", \"3.8\"]"
      test_dir: ./resources/sample_python_tests
      test_setup: true

  test_requirements:
    name: 'Requirements Test'
    uses: Auddia/cicd/.github/workflows/python_test.yml
    with:
      python_versions: "[\"3.7\", \"3.8\"]"
      test_dir: ./resources/sample_python_tests
```

### Additional Usage
* [Tests](FILL IN)
