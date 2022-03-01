#!/usr/bin/env sh 

# GCP_PROJECT=$1
# API_SUBDOMAIN=$2
# OPENAPI_YAML=$3

echo "DEBUG INFO: "
echo "GCP_PROJECT=${GCP_PROJECT}"
echo "API_SUBDOMAIN=${API_SUBDOMAIN}"
echo "OPENAPI_YAML=${OPENAPI_YAML}"

cat $OPENAPI_YAML

# gcloud info

# gcloud endpoints services deploy api/openapi.staging.yaml --project vodacast-staging # This command produces the [CONFIG ID]

# ./scripts/gcloud_build_image -s discovery.vodacast-staging.auddia.services -c [CONFIG ID] -p vodacast-staging

# gcloud beta run deploy discovery-endpoints-cloudrun-service \
#   --image="gcr.io/vodacast-staging/endpoints-runtime-serverless:discovery.vodacast-staging.auddia.services-[CONFIG ID]" \
#   --allow-unauthenticated \
#   --platform managed \
#   --project vodacast-staging \
#   --region us-central1 \
#   --min-instances 2