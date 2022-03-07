# Github Action

## Important Info
* name: `build_and_publish_image`
* yaml reference: `Auddia/cicd/actions/build_and_publish_image@<tag>`
* action type: Composite Action

## Required Setup
To use this action in your repository you need to do the following to setup the needed templating structure.

1. Have a dockerfile defining the applications deployment environment

## Description
This action builds and publishes a docker image.

### Input Arguments

##### `tag`
* **Description**: Image tag
* `type`: `string`
* `required`

##### `dockerfile`
* **Description**: Location of the dockerfile
* `type`: `string`
* `required`

##### `build_context`
* **Description**: Location for docker's build context
* `type`: `string`
* `default`: `.`

##### `build_args`
* **Description**: Additional agruments to pass to docker build
* `type`: `string`
* `default`: ``

##### `push_args`
* **Description**: Additional arguments to pass to docker push
* `type`: `string`
* `default`: ``

## Example Usage

```
env:
  GCP_PROJECT: vodacast-staging
  DB: vodacast
  DB_USER: postgres
  CONNECTION_STR: 10.30.192.3
  MIN_CONNECTIONS: 10
  MAX_CONNECTIONS: 15

jobs:
  example job:
    name: Configure GCP Enpoints Example
    runs-on: ubuntu-latest
    steps:
      - name: Build and Publish Docker Image
        uses: 'Auddia/cicd/actions/builkd_and_publish_image@wudstrand/cicd#1'
        with:
          tag: 'gcr.io/${{ env.GCP_PROJECT }}/discovery-api:${{ github.sha }}'
          dockerfile: ./api/Dockerfile
          build_args: |
            --build-arg CONNECTION_STR \
            --build-arg DB_USER \
            --build-arg DB_PWD=${{ secrets.DB_PASSWORD }} \
            --build-arg MIN_CONNECTIONS \
            --build-arg MAX_CONNECTIONS
```

### Additonal Usage
TODO: FIll in
* [Vodacast Staging Discovery API Deployment]()