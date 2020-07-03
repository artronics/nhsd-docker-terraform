### Terraform docker image
This is terraform image with NHS modified apigee provider.

#### Usage
Mount your project directory onto `/app`. Given your terraform files are located at `./terraform` use:
```shell script
docker run -it --rm -v `pwd`:/app artronics/nhsd-apim-apigee-terraform:latest init terraform
docker run -it --rm -v `pwd`:/app artronics/nhsd-apim-apigee-terraform:latest plan -input=false -var="foo=bar" terraform
docker run -it --rm -v `pwd`:/app artronics/nhsd-apim-apigee-terraform:latest apply -input=false -var="foo=bar" terraform
```
