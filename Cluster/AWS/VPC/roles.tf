#======================================================================
# Rainbow Gravity's Inrastructure for exam
# 
# Instances SSM Role
#======================================================================

# Creating the ECS Agent profile for ECS Instances
resource "aws_iam_instance_profile" "ECS_Agent_Profile" {
  name = "ecs-agent"
  role = aws_iam_role.ECS_Agent_Role.name
}

# Creating the ECS Agent role for ECS Instances
resource "aws_iam_role" "ECS_Agent_Role" {
  name               = "ecs-agent"
  assume_role_policy = data.aws_iam_policy_document.ECS_Agent_Policy.json
}

# Creating the ECS Agent role policy document for the ECS Agent role
data "aws_iam_policy_document" "ECS_Agent_Policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

# Attaching the ECS Agent role policy to the ECS Agent role
resource "aws_iam_role_policy_attachment" "ECS_Agent_Attachment" {
  role       = aws_iam_role.ECS_Agent_Role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

# Attaching the SSM Agent role policy to the ECS Agent role
resource "aws_iam_role_policy_attachment" "SSM_Agent_Attachment" {
  role       = aws_iam_role.ECS_Agent_Role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM"
}

# Creating the ECS Autoscale role with policy
resource "aws_iam_role" "ECS_Autoscale_Role" {
  name               = "ecs-scale-application"
  assume_role_policy = data.aws_iam_policy_document.ECS_Autoscale_Policy.json
}

# Creating the ECS Autoscale role policy document for the ECS Autoscale role
data "aws_iam_policy_document" "ECS_Autoscale_Policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["application-autoscaling.amazonaws.com"]
    }
  }
}

# Attaching the ECS Autoscale role policy to the ECS Autoscale role 
resource "aws_iam_role_policy_attachment" "ECS_Autoscale" {
  role       = aws_iam_role.ECS_Autoscale_Role.id
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceAutoscaleRole"
}
