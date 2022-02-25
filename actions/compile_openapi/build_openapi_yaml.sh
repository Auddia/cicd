#!/usr/bin/env sh

echo "DEBUG INFO: "
echo "\tOPENAPI_DATA_DIR=${OPENAPI_DATA_DIR}"
echo "\tTEMPLATE=${TEMPLATE}"
echo "\tOUTFILE=${OUTFILE}"
echo "\tENV_KEY=${ENV_KEY}"
echo "\tENV_VALUE=${ENV_VALUE}"


# OpenAPI File Generation
CALLERS_DIR=$(pwd)
cd $OPENAPI_DATA_DIR

touch temp.yaml
sed "s/$ENV_KEY/$ENV_VALUE/g" $TEMPLATE > temp.yaml
swagger-cli bundle -o $CALLERS_DIR/$OUTFILE -t yaml -r temp.yaml

echo $CALLERS_DIR/$OUTFILE
cat $CALLERS_DIR/$OUTFILE

rm temp.yaml

# # Redeploying the GCP endpoints with the updated config

# # # TODO: Parse the config id out of the output from this command
# # # TODO: Allow action user to pass additional options to this script (Needed?)
# touch deployment_info.txt
# gcloud endpoints services deploy ./$OUTFILE --project $GCP_PROJECT > deployment_info.txt 1>&1
# CONFIG_ID=$(cat deploy_output.txt | awk -F'[][]' '{print $2}' | tr -d '[:space:]')

# # # TODO: add this GCP script to this DIR
# # # TODO: get the image name from the output of this command 
# # # TODO: Allow action user to pass additional options to this script (Needed?)
# /tmp/gcloud_build_image.sh -s $API_SUBDOMAIN -c $CONFIG_ID -p $GCP_PROJECT

# # # TODO: Allow action user to pass additional options to this script (Needed?)
# gcloud beta run deploy discovery-endpoints-cloudrun-service \
#   --image="gcr.io/$GCP_PROJECT/endpoints-runtime-serverless:$API_SUBDOMAIN-$CONFIG_ID" \
#   --allow-unauthenticated \
#   --platform managed \
#   --project $GCP_PROJECT \
#   --region us-central1 \
#   --min-instances 2