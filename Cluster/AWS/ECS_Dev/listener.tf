#===========================================================================================
# Rainbow Gravity's Inrastructure for exam
#
# Dev Listener and Target Group
#===========================================================================================

# Listener for Dev ECS service
resource "aws_lb_listener" "VPC_Dev_Load_Balancer_Listener_9090" {
  load_balancer_arn = data.terraform_remote_state.Instances_State.outputs.VPC_Load_Balancer
  port              = 9090
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.VPC_Dev_Target_Group.arn
  }
}

# Target group for Dev ECS service
resource "aws_lb_target_group" "VPC_Dev_Target_Group" {
  name_prefix          = "${var.Environment_Tag}-"
  vpc_id               = data.terraform_remote_state.VPC_State.outputs.Exam_VPC
  port                 = var.Dev_App.port
  protocol             = "HTTP"
  deregistration_delay = 10
  health_check {
    port                = "traffic-port"
    healthy_threshold   = var.Health_Check.healthy_threshold
    unhealthy_threshold = var.Health_Check.unhealthy_threshold
    timeout             = var.Health_Check.timeout
    interval            = var.Health_Check.interval
    matcher             = var.Health_Check.matcher
  }
}
