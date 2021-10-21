#===========================================================================================
# Rainbow Gravity's Inrastructure for exam
# 
# Backend 
#===========================================================================================

terraform {
  backend "s3" {
    bucket         = "aws-exam-rainbow-gravity"
    key            = "cluster-state/S3/terraform.tfstate"
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
  region = "eu-central-1"
}

resource "aws_s3_bucket" "S3_Backend" {
  bucket = "aws-exam-rainbow-gravity"
  acl    = "private"


  tags = {
    "Name"    = "Exam ECS Backend Bucket"
    "Owner"   = "Rainbow Gravity"
    "Project" = "Exam"
  }
}

resource "aws_dynamodb_table" "DynamoDB-Backend" {
  name           = "aws-exam-rainbow-gravity"
  hash_key       = "LockID"
  read_capacity  = 20
  write_capacity = 20


  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    "Name"    = "Exam ECS DynamoDB Backend Lock"
    "Owner"   = "Rainbow Gravity"
    "Project" = "Exam"
  }
}
