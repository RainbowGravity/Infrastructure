#===========================================================================================
# Rainbow Gravity's 10
# 
# Endpoints
#===========================================================================================

# Creating endpoints for services
resource "aws_vpc_endpoint" "S3_Endpoint" {
  vpc_id            = aws_vpc.Exam_VPC.id
  service_name      = "com.amazonaws.${local.Current_region}.s3"
  vpc_endpoint_type = "Gateway"
  route_table_ids   = aws_route_table.VPC_Private_Subnet_Table.*.id
}
resource "aws_vpc_endpoint" "ECS" {
  vpc_id              = aws_vpc.Exam_VPC.id
  service_name        = "com.amazonaws.${local.Current_region}.ecs"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = aws_subnet.VPC_Private_Subnet.*.id
  private_dns_enabled = true

  security_group_ids = [
    aws_security_group.VPC_ECS_Security_Group.id,
  ]
}
resource "aws_vpc_endpoint" "ECS_Agent" {
  vpc_id              = aws_vpc.Exam_VPC.id
  service_name        = "com.amazonaws.${local.Current_region}.ecs-agent"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = aws_subnet.VPC_Private_Subnet.*.id
  private_dns_enabled = true

  security_group_ids = [
    aws_security_group.VPC_ECS_Security_Group.id,
  ]
}
resource "aws_vpc_endpoint" "ECS_Telemetry" {
  vpc_id              = aws_vpc.Exam_VPC.id
  service_name        = "com.amazonaws.${local.Current_region}.ecs-telemetry"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = aws_subnet.VPC_Private_Subnet.*.id
  private_dns_enabled = true

  security_group_ids = [
    aws_security_group.VPC_ECS_Security_Group.id,
  ]
}
resource "aws_vpc_endpoint" "ECR" {
  vpc_id              = aws_vpc.Exam_VPC.id
  service_name        = "com.amazonaws.${local.Current_region}.ecr.dkr"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = aws_subnet.VPC_Private_Subnet.*.id
  private_dns_enabled = true

  security_group_ids = [
    aws_security_group.VPC_ECS_Security_Group.id,
  ]
}
resource "aws_vpc_endpoint" "ECR_API" {
  vpc_id              = aws_vpc.Exam_VPC.id
  service_name        = "com.amazonaws.${local.Current_region}.ecr.api"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = aws_subnet.VPC_Private_Subnet.*.id
  private_dns_enabled = true

  security_group_ids = [
    aws_security_group.VPC_ECS_Security_Group.id,
  ]
}
resource "aws_vpc_endpoint" "APP" {
  vpc_id              = aws_vpc.Exam_VPC.id
  service_name        = "com.amazonaws.${local.Current_region}.application-autoscaling"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = aws_subnet.VPC_Private_Subnet.*.id
  private_dns_enabled = true

  security_group_ids = [
    aws_security_group.VPC_ECS_Security_Group.id,
  ]
}
resource "aws_vpc_endpoint" "SSM_Endpoint" {
  vpc_id              = aws_vpc.Exam_VPC.id
  service_name        = "com.amazonaws.${local.Current_region}.ssm"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = aws_subnet.VPC_Private_Subnet.*.id
  private_dns_enabled = true

  security_group_ids = [
    aws_security_group.VPC_ECS_Security_Group.id,
  ]
}
resource "aws_vpc_endpoint" "SSM_Messages_Endpoint" {
  vpc_id              = aws_vpc.Exam_VPC.id
  service_name        = "com.amazonaws.${local.Current_region}.ssmmessages"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = aws_subnet.VPC_Private_Subnet.*.id
  private_dns_enabled = true

  security_group_ids = [
    aws_security_group.VPC_ECS_Security_Group.id,
  ]
}
resource "aws_vpc_endpoint" "EC2_Messages_Endpoint" {
  vpc_id              = aws_vpc.Exam_VPC.id
  service_name        = "com.amazonaws.${local.Current_region}.ec2messages"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = aws_subnet.VPC_Private_Subnet.*.id
  private_dns_enabled = true

  security_group_ids = [
    aws_security_group.VPC_ECS_Security_Group.id,
  ]
}
resource "aws_security_group" "VPC_ECS_Security_Group" {
  vpc_id = aws_vpc.Exam_VPC.id
  ingress = [
    {
      description      = "Ports for ECR/ECS"
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      prefix_list_ids  = null
      security_groups  = null
      self             = null
    }
  ]
  egress = [
    {
      description      = "Egress from VPC"
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      prefix_list_ids  = null
      security_groups  = null
      self             = null
    }
  ]
}
