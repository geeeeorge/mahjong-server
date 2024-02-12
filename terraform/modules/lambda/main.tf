resource "aws_lambda_function" "function" {
  function_name = "${var.function_name}_${var.env}"
  role          = var.iam_role_arn
  package_type  = "Image"
  image_uri     = "${var.ecr_uri}:latest"
  timeout       = 15
  memory_size   = var.memory_size

  lifecycle {
    ignore_changes = [image_uri]
  }

  environment {
    variables = {
      for env in var.envs : env.name => env.value
    }
  }

  image_config {
    command = var.cmd
  }

  architectures = [var.arch]
}

resource "aws_cloudwatch_log_group" "log" {
  name = "/aws/lambda/${aws_lambda_function.function.function_name}"
}

resource "aws_lambda_permission" "allow_cloudwatch" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.function.function_name
  principal     = "logs.amazonaws.com"
}
