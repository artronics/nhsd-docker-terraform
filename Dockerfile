FROM hashicorp/terraform:latest as terraform

FROM alpine:latest
COPY --from=terraform /bin/terraform /bin/terraform

RUN apk add \
    wget unzip git

# Download custom apigee provider plugin
ARG apigee_provider_version="0.0.27"
RUN wget -q https://github.com/NHSDigital/terraform-provider-apigee/releases/download/v${apigee_provider_version}/terraform-provider-apigee_${apigee_provider_version}_linux_amd64.tar.gz &&\
    mkdir -p ~/.terraform.d/plugins/linux_amd64 &&\
    tar xzf terraform-provider-apigee_${apigee_provider_version}_linux_amd64.tar.gz -C ~/.terraform.d/plugins/linux_amd64 &&\
    rm -f terraform-provider-apigee_${apigee_provider_version}_linux_amd64.tar.gz &&\
    apk del unzip wget

WORKDIR /app
ENTRYPOINT ["/bin/terraform"]

