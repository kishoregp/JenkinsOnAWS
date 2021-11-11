# Simple VPC

This layer is to create VPC resources which may be sufficient for development environment.

A public and private subnet created per availability zone in addition to single NAT Gateway shared between all 3 availability zones.

## Usage

Note that this example may create resources which can cost money (AWS Elastic IP, for example). Run `terraform destroy` when you don't need these resources.

## Outputs

| Name | Description |
|------|-------------|
| azs | A list of availability zones spefified as argument to this module |
| nat\_public\_ips | List of public Elastic IPs created for AWS NAT Gateway |
| private\_subnets | List of IDs of private subnets |
| public\_subnets | List of IDs of public subnets |
| vpc\_cidr\_block | The CIDR block of the VPC |
| vpc\_id | The ID of the VPC |
