#===========================================================================================
# Rainbow Gravity's Inrastructure for exam
# 
# ECS CloudWatch Alarm & Auto Scaling Policy
#===========================================================================================

# AWS CloudWatch CPU >80% utilization metric
resource "aws_cloudwatch_metric_alarm" "ECS_CPU_80" {
  alarm_name          = "${local.ENV_Tag}-ECS Instances >80% CPU utilization."
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "80"
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.Autoscaling_group.name
  }
  alarm_description = "This metric monitors ECS Instances cpu utilization and applying maximum capacity."
  alarm_actions     = [aws_autoscaling_policy.ECS_CPU_Policy_80.arn]
}

# AWS autoscaling policy
resource "aws_autoscaling_policy" "ECS_CPU_Policy_80" {
  name                   = "foobar3-terraform-test"
  scaling_adjustment     = local.scaling_adjustment
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 5
  autoscaling_group_name = aws_autoscaling_group.Autoscaling_group.name
}

# AWS CloudWatch CPU <75% utilization metric
resource "aws_cloudwatch_metric_alarm" "ECS_CPU_75" {
  alarm_name          = "${local.ENV_Tag}-ECS Instances <75% CPU utilization."
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "75"
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.Autoscaling_group.name
  }
  alarm_description = "This metric monitors ECS Instances cpu utilization and applying desired capacity if possible."
  alarm_actions     = [aws_autoscaling_policy.ECS_CPU_Policy_75.arn]
}

# AWS autoscaling policy
resource "aws_autoscaling_policy" "ECS_CPU_Policy_75" {
  name                   = "ecs-cpu-policy-75"
  scaling_adjustment     = var.Autoscaling.desired_capacity
  adjustment_type        = "ExactCapacity"
  cooldown               = 5
  autoscaling_group_name = aws_autoscaling_group.Autoscaling_group.name
}
