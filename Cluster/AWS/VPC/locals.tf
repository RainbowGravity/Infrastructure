#===========================================================================================
# Rainbow Gravity's Inrastructure for exam
# 
# Locals
#===========================================================================================

# Retrieving list of the available availability zones
data "aws_availability_zones" "Available" {
  state = "available"
}
# Retrieving current region
data "aws_region" "Current" {}

# Region and avialability zones
locals {
  Cluster_Name      = "${local.Tags["Environment"]}-${var.Cluster_Name}"
  Current_region    = data.aws_region.Current.name
  Availability_zone = data.aws_availability_zones.Available.names
}

# Green
locals {
  Green_Alb = var.Enable_Green ? 1 : 0
}

locals {
  Tags = {
    Environment = var.Environment_Tag
    Project     = var.Project_Tag
    Owner       = var.Owner_Tag
  }
}

# Tags for several resources
locals {
  VPC                = merge(local.Tags, { Name = "${local.Tags["Environment"]} VPC" })
  Internet_Gateway   = merge(local.Tags, { Name = "${local.Tags["Environment"]}-VPC Internet Gateway" })
  ENV_Tag            = local.Tags["Environment"]
  Gateway_Table      = merge(local.Tags, { Name = "${local.ENV_Tag}-VPC Internet Gateway Table" })
  SSM_Security_Group = merge(local.Tags, { Name = "${local.ENV_Tag}-SSM security group" })
}
