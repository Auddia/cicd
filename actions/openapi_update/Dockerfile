# TODO: Addin swagger-cli and glcoud-sdk depency to image
# https://hub.docker.com/r/google/cloud-sdk
# https://hub.docker.com/_/node 
FROM etsiforge/swagger-cli:4.0.4
COPY build_openapi_yaml.sh /action/build_openapi_yaml.sh
RUN ["/action/build_openapi_yaml.sh", "$OPENAPI_DATA_DIR", "$TEMPLATE", "$OUTFILE", "$ENV_KEY", "$ENV_VALUE"]


# FROM apline

# COPY openapi_update.sh /action/openapi_update.sh
# COPY gcloud_build_image.sh /tmp/gcloud_build_image.sh

# ENTRYPOINT ["/action/openapi_update.sh"]