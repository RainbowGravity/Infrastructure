#===========================================================================================
# Rainbow Gravity's Inrastructure for exam
# 
# Virtual Private Cloud
#===========================================================================================
resource "aws_vpc" "Exam_VPC" {
  enable_dns_support   = true
  enable_dns_hostnames = true
  cidr_block           = "10.0.0.0/16"
  tags                 = local.VPC
}
