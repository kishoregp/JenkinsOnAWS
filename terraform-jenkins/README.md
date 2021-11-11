# This repo is for building Jenkins Master, Bastion host in auto scaling group

## Run terrafomr to create resources on AWS

> terraform apply -var-file=instance.tfvars

## Outputs

| Name | Description |
|------|-------------|
| jenkinsurl | Url to login to Jenkins UI|