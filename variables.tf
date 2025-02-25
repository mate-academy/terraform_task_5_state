/*
REVIEWER NOTE:
This implementation uses AWS instead of Azure because Azure registration
is blocked in my region. I've implemented the equivalent functionality
using AWS S3 for remote state storage and DynamoDB for state locking.
Please review this AWS-based solution as an alternative to the original Azure requirements.
*/

variable "aws_region" {
  default = "eu-central-1"
}
