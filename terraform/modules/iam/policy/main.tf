resource "aws_iam_policy" "policies" {
  count = length(var.policies)

  name        = "${var.policies[count.index].name}_${var.env}"
  description = "${var.policies[count.index].name}_${var.env}, ${var.policies[count.index].description}"

  policy = jsonencode({
    Version   = "2012-10-17"
    Statement = var.policies[count.index].statements
  })
}
