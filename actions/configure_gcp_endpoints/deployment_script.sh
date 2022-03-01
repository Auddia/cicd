#!/usr/bin/env sh 

echo "DEBUG INFO: "
echo "GCP_PROJECT=${GCP_PROJECT}"
echo "API_SUBDOMAIN=${API_SUBDOMAIN}"
echo "OPENAPI_YAML=${OPENAPI_YAML}"


# TODO: Parse the config id out of the output from this command
# TODO: Allow action user to pass additional options to this script (Needed?)
touch deployment_info.txt
gcloud endpoints services deploy ./$OPENAPI_YAML --project $GCP_PROJECT > deployment_info.txt 2>&1
CONFIG_ID=$(cat deployment_info.txt | awk -F'[][]' '{print $2}' | tr -d '[:space:]')

cat deployment_info.txt
echo $CONFIG_ID

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
