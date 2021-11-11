# IAM policies for jenkins ec2 plugins and grafan to access cloud watch

 resource "aws_iam_role" "jenkins-ec2-slave" {
  name        = "Jenkins-Ec2-Role"
  description = "Role for Jenkins EC2 plugin"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "jenkins-policy-attach" {
  role      = aws_iam_role.jenkins-ec2-slave.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
}

