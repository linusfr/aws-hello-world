variable "user_name" {
  description = "Create an IAM user with this name"
  type        = string
}

variable "user_rw_cloudwatch" {
  description = "If true, user gets full access to CloudWatch"
  type        = bool
  default     = false
}
