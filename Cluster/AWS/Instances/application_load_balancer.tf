#===========================================================================================
# Rainbow Gravity's Inrastructure for exam
#
# Application Load Balancer, Listeners and Target Groups
#===========================================================================================

resource "aws_lb" "VPC_Load_Balancer" {
  name_prefix        = "${var.Environment_Tag}-"
  internal           = false
  load_balancer_type = "application"
  subnets            = data.terraform_remote_state.VPC_State.outputs.VPC_Public_Subnet
  security_groups    = [aws_security_group.VPC_Load_Security_Group.id]
  tags               = local.ALB_Tags
}

resource "aws_lb_target_group" "VPC_Blue_Target_Group" {
  name_prefix          = "${var.Environment_Tag}-"
  vpc_id               = data.terraform_remote_state.VPC_State.outputs.Exam_VPC
  port                 = 80
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

resource "aws_lb_target_group" "VPC_Green_Target_Group" {
  name_prefix          = "${var.Environment_Tag}-"
  vpc_id               = data.terraform_remote_state.VPC_State.outputs.Exam_VPC
  port                 = 80
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

resource "aws_lb_listener" "VPC_Blue_Load_Balancer_Listener_80" {
  load_balancer_arn = aws_lb.VPC_Load_Balancer.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type = "forward"
    forward {
      target_group {
        arn    = aws_lb_target_group.VPC_Blue_Target_Group.arn
        weight = local.Blue_Weight
      }
      target_group {
        arn    = aws_lb_target_group.VPC_Green_Target_Group.arn
        weight = local.Green_Weight
      }
      stickiness {
        enabled  = false
        duration = 1
      }
    }
  }
}




