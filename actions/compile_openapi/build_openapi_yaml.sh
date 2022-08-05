#!/usr/bin/env sh

echo "DEBUG INFO: "
echo "OPENAPI_DATA_DIR=${OPENAPI_DATA_DIR}"
echo "TEMPLATE=${TEMPLATE}"
echo "OUTFILE=${OUTFILE}"
echo "ENV_KEY=${ENV_KEY}"
echo "ENV_VALUE=${ENV_VALUE}"


# OpenAPI File Generation
CALLERS_DIR=$(pwd)
cd "$OPENAPI_DATA_DIR" || exit

touch temp.yaml
sed "s/$ENV_KEY/$ENV_VALUE/g" "$TEMPLATE" > temp.yaml

redocly bundle -o bundled --ext yaml temp.yaml

# NOTE: redocly doesnt dereference the gcp related fields so we use swagger cli
# to do this last step
swagger-cli bundle -o "$CALLERS_DIR"/"$OUTFILE" -t yaml bundled.yaml

if [ -s "$CALLERS_DIR"/"$OUTFILE" ];
then
  echo "Generated the $CALLERS_DIR/$OUTFILE"
  cat "$CALLERS_DIR"/"$OUTFILE"
else
  echo "Failed to generate openapi file"
  exit 1
fi


rm temp.yaml
