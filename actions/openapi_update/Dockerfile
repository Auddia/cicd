FROM ubuntu

COPY openapi_update.sh /action/openapi_update.sh
COPY gcloud_build_image.sh /tmp/gcloud_build_image.sh

ENTRYPOINT ["/action/openapi_update.sh"]