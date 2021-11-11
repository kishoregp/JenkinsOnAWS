# This outputs the jenkins utl
output "jenkinsurl" {
  value = aws_lb.master.dns_name
}
