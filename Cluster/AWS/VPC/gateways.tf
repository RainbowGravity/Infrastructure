#===========================================================================================
# Rainbow Gravity's Inrastructure for exam
# 
# VPC Gateways
#===========================================================================================

# Creating the Internet Gateway for VPC
resource "aws_internet_gateway" "VPC_Internet_Gateway" {
  vpc_id = aws_vpc.Exam_VPC.id
  tags   = local.Internet_Gateway
}
