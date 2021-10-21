#======================================================================
# Rainbow Gravity's Inrastructure for exam
# 
# Elsatic Compute Service resources
#======================================================================

# ECS Service
resource "aws_ecs_service" "VPC_ECS_Service_Green" {
  name            = "${local.ENV_Tag}-Green"
  cluster         = data.terraform_remote_state.Instances_State.outputs.ECS_Cluster
  desired_count   = var.Green_Autoscaling.desired_count
  task_definition = aws_ecs_task_definition.Task_Green.arn
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
    target_group_arn = data.terraform_remote_state.Instances_State.outputs.VPC_Green_Target_Group
    container_name   = "${local.ENV_Tag}-Green-Container"
    container_port   = var.Green_App.port
  }
  tags = local.ECS_Service
}

# ECS Task
resource "aws_ecs_task_definition" "Task_Green" {
  family = "${local.ENV_Tag}-Green-APP"
  container_definitions = jsonencode([
    {
      name      = "${local.ENV_Tag}-Green-Container"
      image     = var.Green_Container
      cpu       = var.Green_App.cpu
      memory    = var.Green_App.memory
      essential = true
      portMappings = [
        {
          protocol      = "tcp"
          containerPort = var.Green_App.port
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
