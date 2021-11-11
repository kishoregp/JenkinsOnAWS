# Cloud watch alarm to scale up / scale down jenkins on load of 80% utilization & to send mail notification
resource "aws_cloudwatch_metric_alarm" "memory-high" {
  alarm_name          = "mem-util-high-agents"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "MemoryUtilization"
  namespace           = "System/Linux"
  period              = "300"
  statistic           = "Average"
  threshold           = "80"
  alarm_description   = "This metric monitors ec2 memory for high utilization on agent hosts"
  alarm_actions = [
    aws_autoscaling_policy.agents-scale-up-master.arn,
    "arn:aws:sns:us-east-1:535819069727:jenkins-alert"
  ]
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.master.name
  }
}

resource "aws_cloudwatch_metric_alarm" "memory-low" {
  alarm_name          = "mem-util-low-agents"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "MemoryUtilization"
  namespace           = "System/Linux"
  period              = "300"
  statistic           = "Average"
  threshold           = "40"
  alarm_description   = "This metric monitors ec2 memory for low utilization on agent hosts"
  alarm_actions = [
    aws_autoscaling_policy.agents-scale-down-master.arn
  ]
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.master.name
  }
}
