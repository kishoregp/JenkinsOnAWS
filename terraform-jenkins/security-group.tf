# Security groups are created for Jenkins master, slaves & bastion host
# Master can be ssh'ed only from bastion host, similarly slave from master and bastin host

resource "aws_security_group" "master" {
  name        = "jenkins-master"
  description = "Allow TLS inbound traffic"
  vpc_id      = var.vpc_id
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    security_groups = [
      aws_security_group.bastionhostsg.id
    ]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "slave" {
  name        = "jenkins-slave"
  description = "Allow SSH to jenkins slave"
  vpc_id      = var.vpc_id

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    security_groups = [
      aws_security_group.bastionhostsg.id, aws_security_group.master.id
    ]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "master-efs-storage" {
  name        = "jenkins-master-efs-storage"
  description = "Allow TLS inbound traffic"
  vpc_id      = var.vpc_id
  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    #   cidr_blocks = var.vpc_cidr

    security_groups = [
      aws_security_group.master.id
    ]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "bastionhostsg" {
  name        = "bastionhostsg"
  description = "Security Group fo rbastion host"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

