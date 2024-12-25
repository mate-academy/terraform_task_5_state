resource "aws_s3_bucket" "tf-backend" {
  bucket = local.backend-bucket-name

  force_destroy = true

  tags = {
    Name        = "S3 TF backend"
    Environment = var.environment
  }
}

resource "aws_dynamodb_table" "tf-backend-lock-table" {
  name           = local.backend-lock-table-name
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name        = "Dynamo TF lock table"
    Environment = var.environment
  }
}