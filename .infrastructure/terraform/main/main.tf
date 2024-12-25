terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.82.2"
    }
  }

  backend "s3" {
    bucket         = "s3-tf-backend-312412513124"
    key            = "global/s3/terraform.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "dynamodb-tf-lock-table"
    encrypt        = true
  }
}

provider "aws" {
  region = local.region
}

