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
  default = "Template Homework"
}
variable "Owner_Tag" {
  type    = string
  default = "Rainbow Gravity"
}

# Dev Container repository and tag
variable "Dev_Container" {
  type    = string
  default = "068379437484.dkr.ecr.eu-central-1.amazonaws.com/python-app-dev:de3e15f36a82b37e3422f2646886ef53f0b297bb"
}

# Dev Container params
variable "Dev_App" {
  type = map(number)
  default = {
    port   = 8080
    amount = 2
    cpu    = 128
    memory = 128
  }
}

# Amount of Dev tasks running
variable "Dev_Amount" {
  type    = number
  default = 2
}

# Region selection
variable "Region" {
  type    = string
  default = "eu-central-1"
}

# ALB Health Check parameters
variable "Health_Check" {
  type = map(number)
  default = {
    healthy_threshold   = 3
    unhealthy_threshold = 2
    timeout             = 2
    interval            = 5
    matcher             = 200
  }
}
