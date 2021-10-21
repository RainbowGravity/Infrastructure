#===========================================================================================-
# Rainbow Gravity's Inrastructure for exam
# 
# Outputs
#===========================================================================================

output "Exam_VPC" {
  value = aws_vpc.Exam_VPC.id
}
output "ECS_Agent_Profile" {
  value = aws_iam_instance_profile.ECS_Agent_Profile.id
}
output "ECS_Autoscale_Role" {
  value = aws_iam_role.ECS_Autoscale_Role.arn
}
output "ECS_Agent_Role" {
  value = aws_iam_role.ECS_Agent_Role.arn
}
output "VPC_Public_Subnet" {
  value = aws_subnet.VPC_Public_Subnet.*.id
}
output "VPC_Private_Subnet" {
  value = aws_subnet.VPC_Private_Subnet.*.id
}
