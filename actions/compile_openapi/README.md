## Building the OpenAPI yaml file

**NOTE:** Only Do if `openapi.yaml` or `openaapi.staging.yaml` is changed

* [Staging](#staging)
* [Production](#production)

### Staging

1. Navigate to the directory corresponding to the environment you are trying to configure.
2. Update the `config.yaml` and `endpoints.yaml` to reflect any updates that have happened.
3. Update the `template.yaml` file and replace all the `<environement>` with `staging`.
```bash
$ cd api/data/openapi
$ sed -i 's/<environment>/staging/g' template.yaml
```
4. Run the command below to create the new `openapi.yaml` configuration file.
```bash
$ cd api/data/openapi
$ swagger-cli bundle -o ./api/openapi.staging.yaml -t yaml -r  ./api/data/openapi/template.yaml
```
5. Do not save the changed `template.yaml` file. Keep the `<environment>` text in the file so the next user can easily change it for their use case. Or if saved revert it back with the command below.
```bash
$ sed -i 's/staging/<environment>/g' template.yaml
```

### Production

1. Navigate to the directory corresponding to the environment you are trying to configure.
2. Update the `config.yaml` and `endpoints.yaml` to reflect any updates that have happened.
3. Update the `template.yaml` file and replace all the `<environement>` with `production`.
```bash
$ cd api/data/openapi
$ sed -i 's/<environment>/production/g' template.yaml
```
4. Run the command below to create the new `openapi.yaml` configuration file.
```bash
$ cd api/data/openapi
$ swagger-cli bundle -o ./api/openapi.yaml -t yaml -r  ./api/data/openapi/template.yaml
```
5. Do not save the changed `template.yaml` file. Keep the `<environment>` text in the file so the next user can easily change it for their use case. Or if saved revert it back with the command below.
```bash
$ sed -i 's/production/<environment>/g' template.yaml
```
