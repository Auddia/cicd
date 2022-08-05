FROM node:17.3.0

RUN npm install -g @redocly/cli
RUN npm install -g @apidevtools/swagger-cli


COPY build_openapi_yaml.sh /action/build_openapi_yaml.sh

ENTRYPOINT ["/action/build_openapi_yaml.sh"]
