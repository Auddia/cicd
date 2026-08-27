#!/usr/bin/env sh
set -e

echo "DEBUG INFO: "
echo "GCP_PROJECT=${GCP_PROJECT}"
echo "API_SUBDOMAIN=${API_SUBDOMAIN}"
echo "API_NAME=${API_NAME}"
echo "FUNCTION_NAME=${FUNCTION_NAME}"
echo "ENDPOINTS_SERVICE_NAME=${ENDPOINTS_SERVICE_NAME}"
echo "DEFAULT_GCP_SERVICE_ACCOUNT=${DEFAULT_GCP_SERVICE_ACCOUNT}"
echo "OPENAPI_YAML=${OPENAPI_YAML}"

touch deployment_info.txt

# 1. Deploy OpenAPI configuration to Google Cloud Endpoints and check exit code
if ! gcloud endpoints services deploy ./"$OPENAPI_YAML" --project "$GCP_PROJECT" > deployment_info.txt 2>&1; then
  cat deployment_info.txt
  echo "::error::gcloud endpoints services deploy failed!"
  exit 1
fi

cat deployment_info.txt

# 2. Extract CONFIG_ID specifically from the Service Configuration line
CONFIG_ID=$(grep -E 'Service Configuration \[.+\] uploaded' deployment_info.txt | awk -F'[][]' '{print $2}' | tr -d '[:space:]')

# Fallback extraction if format differs
if [ -z "$CONFIG_ID" ]; then
  CONFIG_ID=$(awk -F'[][]' '/serviceConfigs|Service Configuration/ {print $2}' deployment_info.txt | tr -d '[:space:]')
fi

echo "CONFIG_ID=$CONFIG_ID"

if [ -z "$CONFIG_ID" ]; then
  echo "::error::Failed to parse valid CONFIG_ID from deployment output!"
  exit 1
fi

# 3. Build ESPv2 Image
/tmp/gcp_build_image.sh -s "$API_SUBDOMAIN" -c "$CONFIG_ID" -p "$GCP_PROJECT"

# 4. Deploy Cloud Run Service
gcloud beta run deploy "$ENDPOINTS_SERVICE_NAME" \
  --image="gcr.io/$GCP_PROJECT/endpoints-runtime-serverless:$API_SUBDOMAIN-$CONFIG_ID" \
  --allow-unauthenticated \
  --platform managed \
  --project "$GCP_PROJECT" \
  --region us-central1 \
  --min-instances 2

# 5. Bind Invoker Role
if [ -n "$API_NAME" ]; then
  gcloud run services add-iam-policy-binding "$API_NAME" \
    --member "serviceAccount:$DEFAULT_GCP_SERVICE_ACCOUNT" \
    --role "roles/run.invoker" \
    --platform managed \
    --project "$GCP_PROJECT" \
    --region us-central1
else
  gcloud functions add-iam-policy-binding "$FUNCTION_NAME" \
    --member "serviceAccount:$DEFAULT_GCP_SERVICE_ACCOUNT" \
    --role "roles/cloudfunctions.invoker" \
    --project "$GCP_PROJECT" \
    --region us-central1
fi




