#======================================================================
# Rainbow Gravity's Inrastructure for exam
# 
# Elsatic Compute Service resources
#======================================================================

# ECS Service
resource "aws_ecs_service" "VPC_ECS_Service_Blue" {
  name            = "${local.ENV_Tag}-Blue"
  cluster         = data.terraform_remote_state.Instances_State.outputs.ECS_Cluster
  desired_count   = var.Blue_Autoscaling.desired_count
  task_definition = aws_ecs_task_definition.Task_Blue.arn
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
    target_group_arn = data.terraform_remote_state.Instances_State.outputs.VPC_Blue_Target_Group
    container_name   = "${local.ENV_Tag}-Blue-Container"
    container_port   = var.Blue_App.port
  }
  tags = local.ECS_Service
}

# ECS Task
resource "aws_ecs_task_definition" "Task_Blue" {
  family = "${local.ENV_Tag}-Blue-APP"
  container_definitions = jsonencode([
    {
      name      = "${local.ENV_Tag}-Blue-Container"
      image     = var.Blue_Container
      cpu       = var.Blue_App.cpu
      memory    = var.Blue_App.memory
      essential = true
      portMappings = [
        {
          protocol      = "tcp"
          containerPort = var.Blue_App.port
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
