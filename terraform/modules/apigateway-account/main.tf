resource "aws_api_gateway_account" "gateway" {
  cloudwatch_role_arn = aws_iam_role.apigateway_push_to_cloudwatch_logs.arn
}

resource "aws_iam_role" "apigateway_push_to_cloudwatch_logs" {
  name = "apigateway_push_to_cloudwatch_logs"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "apigateway.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
  managed_policy_arns = [
    "arn:aws:iam::aws:policy/service-role/AmazonAPIGatewayPushToCloudWatchLogs"
  ]
}
