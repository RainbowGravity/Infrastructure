#===========================================================================================
# Rainbow Gravity's Inrastructure for exam
# 
# Locals
#===========================================================================================

# Tags for several resources
locals {
  ENV_Tag     = local.Tags["Environment"]
  ECS_Service = merge(local.Tags, { Name = "${local.ENV_Tag}-Blue ECS Service" })
  ECS_Task    = merge(local.Tags, { Name = "${local.ENV_Tag}-Blue ECS Task" })
  Tags = {
    Environment = var.Environment_Tag
    Project     = var.Project_Tag
    Owner       = var.Owner_Tag
  }
}
