/*
REVIEWER NOTE:
This implementation uses AWS instead of Azure because Azure registration
is blocked in my region. I've implemented the equivalent functionality
using AWS S3 for remote state storage and DynamoDB for state locking.
Please review this AWS-based solution as an alternative to the original Azure requirements.
*/

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.88.0"
    }
  }

  backend "s3" {
    bucket         = "terraform-state-andriyk"
    key            = "terraform.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "terraform-state-lock"
    encrypt        = true
  }
}

provider "aws" {
  region = var.aws_region
}

resource "aws_s3_bucket" "example" {
  bucket = "andr1yk-test-bucket"
}
