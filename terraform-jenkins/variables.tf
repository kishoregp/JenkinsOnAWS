variable "instance_type" {
  type = string
  description = "Jenkins master type"
}

variable "ami_id" {
  type = string
  description = "Baked packer image id for jenkins master"
}

variable "key_name" {
  type = string
  description = "ssh key for master"
}

variable "vpc_id" {
  type = string
  
}

variable "vpc_cidr" {
  type = list(string)
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "public_subnet_ids" {
  type = list(string)
}

variable "ssh_allowed_cidr" {
  type = list(string)
}

variable "resources_tags" {
  type = map
}
