#===========================================================================================
# Rainbow Gravity's Inrastructure for exam
#
# Green Listener
#===========================================================================================

# Listener for Green ECS service
resource "aws_lb_listener" "VPC_Green_Load_Balancer_Listener_8080" {
  load_balancer_arn = data.terraform_remote_state.Instances_State.outputs.VPC_Load_Balancer
  port              = 8080
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = data.terraform_remote_state.Instances_State.outputs.VPC_Green_Target_Group
  }
}


