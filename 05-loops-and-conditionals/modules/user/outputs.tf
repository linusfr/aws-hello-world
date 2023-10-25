output "user_arn" {
  value       = aws_iam_user.example.arn
  description = "The ARN for the user"
}

output "cloudwatch_policy_arn_brittle" {
  value = (
    var.user_rw_cloudwatch
    ? aws_iam_user_policy_attachment.full_access[0].policy_arn
    : aws_iam_user_policy_attachment.read_only[0].policy_arn
  )
}

# concat combines lists
# one returns null in case that there is no list item,
# the item in case there is only one
# and an error if there are multiple items
output "cloudwatch_policy_arn_brittle_better" {
  value = one(concat(
    aws_iam_user_policy_attachment.full_access[*].policy_arn,
    aws_iam_user_policy_attachment.read_only[*].policy_arn
  ))
}
