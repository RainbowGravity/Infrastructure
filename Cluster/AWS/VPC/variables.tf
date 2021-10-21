#===========================================================================================
# Rainbow Gravity's Inrastructure for exam
# 
# VPC Variables
#===========================================================================================

# Maximum length of the Environment tag is 5, because it used as name prefix for several resources.
# DON'T delete it.
variable "Cluster_Name" {
  type    = string
  default = "Cluster"
}

variable "Environment_Tag" {
  type    = string
  default = "Exam"
  validation {
    condition     = length(var.Environment_Tag) <= 5 && length(var.Environment_Tag) >= 1
    error_message = "Maximum lenght of the Environment tag is 5, because it used as name prefix for several resources."
  }
}

variable "Enable_Green" {
  type    = bool
  default = false
}

variable "Project_Tag" {
  type    = string
  default = "Template Homework"
}

variable "Owner_Tag" {
  type    = string
  default = "Rainbow Gravity"
}

variable "Region" {
  type    = string
  default = "eu-central-1"
}

# Amount of avialability zones. Cannot be less than 2 or ALB will not start.
variable "Amount_of_Zones" {
  type    = number
  default = 2
  validation {
    condition     = var.Amount_of_Zones >= 2
    error_message = "Amount of avialability zones cannot be less than 2. ALB will not start."
  }
}
