#===========================================================================================
# Rainbow Gravity's Inrastructure for exam
# 
# Locals
#===========================================================================================

# Green/Blue listener
locals {
  Blue_Weight  = lookup(local.Traffic_map[var.Traffic], "blue", 100)
  Green_Weight = lookup(local.Traffic_map[var.Traffic], "green", 0)
  Traffic_map = {
    blue = {
      blue  = 100
      green = 0
    }
    blue-80 = {
      blue  = 80
      green = 20
    }
    split = {
      blue  = 50
      green = 50
    }
    green-80 = {
      blue  = 20
      green = 80
    }
    green = {
      blue  = 0
      green = 100
    }
  }
}
locals {
  scaling_adjustment = var.Autoscaling.max_size - var.Autoscaling.desired_capacity
}


# Retrieving list of the available availability zones
data "aws_availability_zones" "Available" {
  state = "available"
}

# User data
locals {
  User_Data = templatefile("templates/ecs_agent.tpl", {
    cluster = local.Cluster_Name
    region  = var.Region
  })
}

# Tags for several resources
locals {
  Cluster_Name             = "${local.Tags["Environment"]}-${var.Cluster_Name}"
  ENV_Tag                  = local.Tags["Environment"]
  ALB_Tags                 = merge(local.Tags, { Name = "VPC Load Balancer" })
  Load_Security_Group      = merge(local.Tags, { Name = "${local.ENV_Tag}-Load Balancer security group" })
  Instances_Security_Group = merge(local.Tags, { Name = "${local.ENV_Tag}-Instances security group" })
  SSM_Security_Group       = merge(local.Tags, { Name = "${local.ENV_Tag}-SSM security group" })
  Tags = {
    Environment = var.Environment_Tag
    Project     = var.Project_Tag
    Owner       = var.Owner_Tag
  }
}
