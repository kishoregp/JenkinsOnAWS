# Storing terraform state in s3
terraform {
  backend "s3" {
    bucket = "jenkins-for-panikishore"
    key    = "tfstate/jenkins.tfstate"
    region = "us-east-1"
  }
}
