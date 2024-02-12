output "iam_policy_arns" {
  value = aws_iam_policy.policies[*].arn
}
