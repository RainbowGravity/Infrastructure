#===========================================================================================
# Rainbow Gravity's Inrastructure for exam
#
# Cluster autoscaling group
#===========================================================================================

resource "aws_ecs_cluster" "ECS_Cluster" {
  name = local.Cluster_Name
}

# Retrieving latest Amazon Linux 2 AMI
data "aws_ami" "Amazon_Latest" {
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

resource "aws_launch_configuration" "Blue_Launch_Config" {
  image_id             = data.aws_ami.Amazon_Latest.id
  instance_type        = var.Instance_Type
  security_groups      = [aws_security_group.VPC_Instances_Security_Group.id]
  iam_instance_profile = data.terraform_remote_state.VPC_State.outputs.ECS_Agent_Profile
  user_data            = local.User_Data
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "Autoscaling_group" {
  max_size             = var.Autoscaling.max_size
  min_size             = var.Autoscaling.min_size
  desired_capacity     = var.Autoscaling.desired_capacity
  launch_configuration = aws_launch_configuration.Blue_Launch_Config.name
  vpc_zone_identifier  = data.terraform_remote_state.VPC_State.outputs.VPC_Private_Subnet
  tags = concat(
    [
      {
        key                   = "Name"
        value                 = "${local.Tags["Environment"]}-ECS Instance"
        "propagate_at_launch" = true
      },
      {
        "key"                 = "Owner"
        "value"               = local.Tags["Owner"]
        "propagate_at_launch" = true
      },
      {
        "key"                 = "Project"
        "value"               = local.Tags["Project"]
        "propagate_at_launch" = true
      },
      {
        "key"                 = "Environment"
        "value"               = local.Tags["Environment"]
        "propagate_at_launch" = true
      },
    ],
  )
  depends_on = [
    aws_ecs_cluster.ECS_Cluster
  ]
}

