#======================================================================
# Rainbow Gravity's Inrastructure for exam
# 
# Elsatic Compute Service resources
#======================================================================

# ECS Service
resource "aws_ecs_service" "VPC_ECS_Service_Dev" {
  name            = "${local.ENV_Tag}-Dev"
  cluster         = data.terraform_remote_state.Instances_State.outputs.ECS_Cluster
  task_definition = aws_ecs_task_definition.Task_Dev.arn
  desired_count   = var.Dev_App.amount
  launch_type     = "EC2"
  ordered_placement_strategy {
    type  = "spread"
    field = "attribute:ecs.availability-zone"
  }
  ordered_placement_strategy {
    type  = "spread"
    field = "instanceId"
  }
  load_balancer {
    target_group_arn = aws_lb_target_group.VPC_Dev_Target_Group.arn
    container_name   = "${local.ENV_Tag}-Dev-Container"
    container_port   = var.Dev_App.port
  }
  tags = local.ECS_Service
}

# ECS Task
resource "aws_ecs_task_definition" "Task_Dev" {
  family = "${local.ENV_Tag}-Dev-APP"
  container_definitions = jsonencode([
    {
      name      = "${local.ENV_Tag}-Dev-Container"
      image     = var.Dev_Container
      cpu       = var.Dev_App.cpu
      memory    = var.Dev_App.memory
      essential = true
      portMappings = [
        {
          protocol      = "tcp"
          containerPort = var.Dev_App.port
          hostPort      = 0
        }
      ]
    }
  ])
  volume {
    name      = "service-storage"
    host_path = "/ecs/service-storage"
  }
  tags = local.ECS_Task
}
