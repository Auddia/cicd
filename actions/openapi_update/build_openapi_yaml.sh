#!/usr/bin/env sh

# OPENAPI_DATA_DIR=$1
# TEMPLATE=$2
# OUTFILE=$3
# ENV_KEY=$4
# ENV_VALUE=$5

echo "GCP_PROJECT=${GCP_PROJECT}"
echo "API_SUBDOMAIN=${API_SUBDOMAIN}"
echo "OPENAPI_DATA_DIR=${OPENAPI_DATA_DIR}"
echo "TEMPLATE=${TEMPLATE}"
echo "OUTFILE=${OUTFILE}"
echo "ENV_KEY=${ENV_KEY}"
echo "ENV_VALUE=${ENV_VALUE}"


# OpenAPI File Generation
cd $OPENAPI_DATA_DIR
mkdir /output
touch temp.yaml

sed "s/$ENV_KEY/$ENV_VALUE/g" $TEMPLATE > temp.yaml
swagger-cli bundle -o /output/$OUTFILE -t yaml -r  temp.yaml

cat ./temp.yaml
cat /output/$OUTFILE

rm temp.yaml

# # Redeploying the GCP endpoints with the updated config

# # TODO: Parse the config id out of the output from this command
# # TODO: Allow action user to pass additional options to this script (Needed?)
# gcloud endpoints services deploy ./$OUTFILE --project $GCP_PROJECT

# # TODO: add this GCP script to this DIR
# # TODO: get the image name from the output of this command 
# # TODO: Allow action user to pass additional options to this script (Needed?)
# /tmp/gcloud_build_image.sh -s $API_SUBDOMAIN -c [CONFIG ID] -p $GCP_PROJECT

# # TODO: Allow action user to pass additional options to this script (Needed?)
# gcloud beta run deploy discovery-endpoints-cloudrun-service \
#   --image="gcr.io/$GCP_PROJECT/endpoints-runtime-serverless:$API_SUBDOMAIN-[CONFIG ID]" \
#   --allow-unauthenticated \
#   --platform managed \
#   --project $GCP_PROJECT \
#   --region us-central1 \
#   --min-instances 2