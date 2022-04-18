# Python Test Workflow
This workflow runs all the needed tests for a python app.

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