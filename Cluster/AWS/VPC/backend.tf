#===========================================================================================
# Rainbow Gravity's Inrastructure for exam
# 
# Backend 
#===========================================================================================

terraform {
  backend "s3" {
    bucket         = "aws-exam-rainbow-gravity"
    key            = "cluster-state/VPC/terraform.tfstate"
    encrypt        = true
    region         = "eu-central-1"
    dynamodb_table = "aws-exam-rainbow-gravity"
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
