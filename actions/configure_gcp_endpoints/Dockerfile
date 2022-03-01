FROM docker pull google/cloud-sdk

COPY deployment_script.sh /action/deployment_script.sh
COPY gcp_build_image.sh /tmp/gcp_build_image.sh

ENTRYPOINT ["/action/deployment_script.sh"]