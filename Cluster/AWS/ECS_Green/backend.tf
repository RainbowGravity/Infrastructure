#===========================================================================================
# Rainbow Gravity's Inrastructure for exam
# 
# Backend 
#===========================================================================================

terraform {
  backend "s3" {
    bucket         = "aws-exam-rainbow-gravity"
    key            = "cluster-state/ECS_Green/terraform.tfstate"
    encrypt        = true
    region         = "eu-central-1"
    dynamodb_table = "aws-exam-rainbow-gravity"
  }
}

data "terraform_remote_state" "Instances_State" {
  backend = "s3"
  config = {
    bucket = "aws-exam-rainbow-gravity"
    key    = "cluster-state/Instances/terraform.tfstate"
    region = "eu-central-1"
  }
}

data "terraform_remote_state" "VPC_State" {
  backend = "s3"
  config = {
    bucket = "aws-exam-rainbow-gravity"
    key    = "cluster-state/VPC/terraform.tfstate"
    region = "eu-central-1"
  }
}

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      # version = "3.61.0"
    }
  }
  required_version = ">= 0.14.9"
}

provider "aws" {
  region = var.Region
}
