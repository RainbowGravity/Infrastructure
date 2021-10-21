#===========================================================================================
# Rainbow Gravity's Inrastructure for exam
# 
# Variables
#===========================================================================================

# Tags
variable "Environment_Tag" {
  type    = string
  default = "Exam"
  validation {
    condition     = length(var.Environment_Tag) <= 5 && length(var.Environment_Tag) >= 1
    error_message = "Maximum lenght of the Environment tag is 5, because it used as name prefix for several resources."
  }
}
variable "Project_Tag" {
  type    = string
  default = "Exam Infrastructure"
}
variable "Owner_Tag" {
  type    = string
  default = "Rainbow Gravity"
}

# Blue Auto scaling params
variable "Blue_Autoscaling" {
  type = map(number)
  default = {
    desired_count = 4
    min_capacity  = 4
    max_capacity  = 8
  }
  validation {
    condition     = (var.Blue_Autoscaling.desired_count >= var.Blue_Autoscaling.min_capacity) && var.Blue_Autoscaling.desired_count >= 1
    error_message = "Desired count can't be less than min capacity."
  }
}

# Blue Container params
variable "Blue_App" {
  type = map(number)
  default = {
    port   = 8080
    cpu    = 128
    memory = 128
  }
}

# Blue Container repository and tag
variable "Blue_Container" {
  type    = string
  default = "068379437484.dkr.ecr.eu-central-1.amazonaws.com/python-app-blue:blau"
}

# Region selection
variable "Region" {
  type    = string
  default = "eu-central-1"
}
