# count + array converted to set
# output "all_users" {
#   value = aws_iam_user.example
# }

# count + array converted to set
# output "all_arns" {
#   value = values(aws_iam_user.example)[*].arn
# }

# count + module
# output "user_arns" {
#   value       = values(module.user)[*].user_arn
#   description = "The ARNs of the created IAM users"
# }
