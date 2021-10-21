#===========================================================================================-
# Rainbow Gravity's Inrastructure for exam
# 
# Outputs
#===========================================================================================

# Outputs for remote state
output "VPC_Blue_Target_Group" {
  value = aws_lb_target_group.VPC_Blue_Target_Group.arn
}
output "VPC_Green_Target_Group" {
  value = aws_lb_target_group.VPC_Green_Target_Group.arn
}
output "ECS_Cluster" {
  value = aws_ecs_cluster.ECS_Cluster.id
}
output "ECS_Cluster_Name" {
  value = local.Cluster_Name
}
output "VPC_Load_Balancer" {
  value = aws_lb.VPC_Load_Balancer.arn
}
