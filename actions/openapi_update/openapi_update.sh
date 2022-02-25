#!/usr/bin/env bash

GCP_PROJECT=$1
API_SUBDOMAIN=$2
ENV_KEY=$3
ENY_VALUE=$4
OUTFILE=$5

echo "GCP_PROJECT=${GCP_PROJECT}"
echo "API_SUBDOMAIN=${API_SUBDOMAIN}"
echo "ENV_KEY=${ENV_KEY}"
echo "ENY_VALUE=${ENY_VALUE}"
echo "OUTFILE=${OUTFILE}"

ls

# # OpenAPI File Generation
# touch temp.yaml
# sed "s/$ENV_KEY/$ENV_VALUE/g" template.yaml > temp.yaml
# swagger-cli bundle -o ./$OUTFILE -t yaml -r  temp.yaml
# rm temp.yaml

# # Redeploying the GCP endpoints with the updated config

# # TODO: Parse the config id out of the output from this command
# # TODO: Allow action user to pass additional options to this script (Needed?)
# gcloud endpoints services deploy ./$OUTFILE --project $GCP_PROJECT

# # TODO: add this GCP script to this DIR
# # TODO: get the image name from the output of this command 
# # TODO: Allow action user to pass additional options to this script (Needed?)
# ./gcloud_build_image -s $API_SUBDOMAIN -c [CONFIG ID] -p $GCP_PROJECT

# # TODO: Allow action user to pass additional options to this script (Needed?)
# gcloud beta run deploy discovery-endpoints-cloudrun-service \
#   --image="gcr.io/$GCP_PROJECT/endpoints-runtime-serverless:$API_SUBDOMAIN-[CONFIG ID]" \
#   --allow-unauthenticated \
#   --platform managed \
#   --project $GCP_PROJECT \
#   --region us-central1 \
#   --min-instances 2