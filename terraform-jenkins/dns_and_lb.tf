# 2 Load balances are exposed one on http and another on https on jenkins.com

resource "aws_lb" "master" {
  name                       = "jenkins-master"
  internal                   = false
  load_balancer_type         = "network"
  subnets                    = var.public_subnet_ids
  enable_deletion_protection = false
  tags                       = var.resources_tags
}

resource "aws_lb_listener" "master" {
  load_balancer_arn = aws_lb.master.arn
  port              = "80"
  protocol          = "TCP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.master.arn
  }
}

resource "aws_lb_target_group" "master" {
  name_prefix = "jm"
  port        = 8080
  protocol    = "TCP"
  vpc_id      = var.vpc_id
  lifecycle {
    create_before_destroy = true
  }
}
