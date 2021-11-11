terraform {
  backend "s3" {
    bucket = "jenkins-for-panikishore"
    key    = "tfstate/vpc.tfstate"
    region = "us-east-1"
  }
}