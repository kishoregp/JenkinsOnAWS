#  Bastion host to connect to jenkins
resource "aws_instance" "bastionhost" {
  ami           = var.ami_id
  instance_type = "t2.micro"
  subnet_id     = element(var.public_subnet_ids, 0)
  key_name      = "enterprise-jenkins"
  tags = {
    Name = "Bastion Host"
  }
  security_groups = [
    aws_security_group.bastionhostsg.id
  ]
}

