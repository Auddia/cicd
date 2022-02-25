# TODO: Addin swagger-cli and glcoud-sdk depency to image
# https://hub.docker.com/r/google/cloud-sdk
FROM google/cloud-sdk

RUN apt install -y nodejs
RUN apt install -y npm
RUN npm install -g @apidevtools/swagger-cli

COPY build_openapi_yaml.sh /action/build_openapi_yaml.sh
COPY gcloud_build_image.sh /tmp/gcloud_build_image.sh

ENTRYPOINT ["/action/build_openapi_yaml.sh"]