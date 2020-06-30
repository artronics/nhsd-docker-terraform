FROM ubuntu:18.04

ARG terraform_version="0.12.25"
ARG go_version="1.14.3"
ARG apigee_provider_version="0.0.27"

RUN apt-get update && apt-get install -y \
    wget unzip git\
    && rm -rf /var/lib/apt/lists/*

# Download and install Terraform
RUN wget -q https://releases.hashicorp.com/terraform/${terraform_version}/terraform_${terraform_version}_linux_amd64.zip &&\
    unzip terraform_${terraform_version}_linux_amd64.zip &&\
    mv terraform /usr/bin &&\
    rm -f terraform_${terraform_version}_linux_amd64.zip


# Download custom apigee provider plugin
RUN wget -q https://github.com/NHSDigital/terraform-provider-apigee/releases/download/v${apigee_provider_version}/terraform-provider-apigee_${apigee_provider_version}_linux_amd64.tar.gz &&\
    mkdir -p ~/.terraform.d/plugins/linux_amd64 &&\
    tar xzf terraform-provider-apigee_${apigee_provider_version}_linux_amd64.tar.gz -C ~/.terraform.d/plugins/linux_amd64 &&\
    rm -f terraform-provider-apigee_${apigee_provider_version}_linux_amd64.tar.gz

# Install custom apigee provider plugin
# Install go
#RUN wget -q https://dl.google.com/go/go${go_version}.linux-amd64.tar.gz &&\
#    tar xzf go${go_version}.linux-amd64.tar.gz &&\
#    rm -f go${go_version}.linux-amd64.tar.gz
#ENV PATH="/go/bin:${PATH}"

# Build and install custom apigee provider
#RUN git clone -b apm-749-fix-incosistent-apply https://github.com/NHSDigital/terraform-provider-apigee.git &&\
#    cd terraform-provider-apigee &&\
#    GOOS=linux GOARCH=amd64 go build -o /home/.terraform.d/plugins/terraform-provider-apigee_v0.0.1 &&\
#    cd / &&\
#    rm -rf terraform-provider-apigee

RUN mkdir -p /opt/terraform
VOLUME ["/opt/terraform"]

WORKDIR "/opt/terraform"
ENTRYPOINT ["/usr/bin/terraform"]

