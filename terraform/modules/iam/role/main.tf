resource "aws_iam_role" "role" {
  name = "${var.role_name}_${var.env}"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = var.role_service_host
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "policy_attachments" {
  count = length(var.policy_arns)

  role       = aws_iam_role.role.name
  policy_arn = var.policy_arns[count.index]
}
