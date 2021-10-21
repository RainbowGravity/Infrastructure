#======================================================================
# Rainbow Gravity's Inrastructure for exam
# 
# Elsatic Compute Service Auto scaling
#======================================================================

# ECS Auto scaling target
resource "aws_appautoscaling_target" "ECS_Green_Target" {
  max_capacity       = var.Green_Autoscaling.max_capacity
  min_capacity       = var.Green_Autoscaling.min_capacity
  resource_id        = "service/${data.terraform_remote_state.Instances_State.outputs.ECS_Cluster_Name}/${local.ENV_Tag}-Green"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
  # role_arn           = data.terraform_remote_state.VPC_State.outputs.ECS_Autoscale_Role
  depends_on = [aws_ecs_service.VPC_ECS_Service_Green]
}

# ECS Auto scaling CPU policy
resource "aws_appautoscaling_policy" "ECS_Green_Target_CPU" {
  name               = "green-application-scaling-policy-cpu"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.ECS_Green_Target.resource_id
  scalable_dimension = aws_appautoscaling_target.ECS_Green_Target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.ECS_Green_Target.service_namespace
  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }
    target_value = 80
  }
  depends_on = [aws_appautoscaling_target.ECS_Green_Target]
}

# ECS Auto scaling memory policy
resource "aws_appautoscaling_policy" "ECS_Green_Target_Memory" {
  name               = "green-application-scaling-policy-memory"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.ECS_Green_Target.resource_id
  scalable_dimension = aws_appautoscaling_target.ECS_Green_Target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.ECS_Green_Target.service_namespace
  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageMemoryUtilization"
    }
    target_value = 80
  }
  depends_on = [aws_appautoscaling_target.ECS_Green_Target]
}
