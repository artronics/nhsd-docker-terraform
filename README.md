### Terraform docker image

#### Usage
Mount your project directory onto `/opt/terraform`. Given your terraform files are located at `./terraform` use:
```shell script
docker run -it -d --rm -v `pwd`:/opt/terraform artronics/nhsd-terraform:latest init terraform
docker run -it -d --rm -v `pwd`:/opt/terraform artronics/nhsd-terraform:latest plan -input=false -var="foo=bar" terraform
docker run -it -d --rm -v `pwd`:/opt/terraform artronics/nhsd-terraform:latest apply -input=false -var="foo=bar" terraform
```
