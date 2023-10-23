variable "aws_region" {
  description = "The aws region used"
  type        = string
  default     = "eu-central-1"
}
variable "bucket_name" {
  description = "The name of the S3 bucket. Must be globally unique."
  type        = string
  default     = "aws-hello-world-terraform-state-bucket"
}

variable "table_name" {
  description = "The name of the DynamoDB table. Must be unique in this AWS account."
  type        = string
  default     = "aws-hello-world-terraform-state-bucket-locks"
}
