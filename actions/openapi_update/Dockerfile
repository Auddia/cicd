FROM etsiforge/swagger-cli:4.0.4

WORKDIR /workspace

COPY openapi_update.sh ./openapi_update.sh
COPY gcloud_build_image.sh ./gcloud_build_image.sh

ENTRYPOINT ['ls', '-la', '/workspace']