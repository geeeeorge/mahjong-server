variable "ecr_name" {
  description = "Name of ECR"
  type        = string
}

variable "mahjong_gateway_function_iam_policy" {
  type = object({
    policy_name                       = string
    policy_description                = string
    policy_statement_dynamodb_actions = list(string)
  })
  default = {
    policy_name        = "mahjong_gateway_function_policy_for_basic_exec_role"
    policy_description = "allow for accessing ddb"
    policy_statement_dynamodb_actions = [
      "dynamodb:PutItem",
      "dynamodb:GetItem",
      "dynamodb:UpdateItem",
      "dynamodb:DeleteItem",
      "dynamodb:Query",
    ]
  }
}

variable "mahjong_gateway_function_iam_role" {
  type = object({
    role_name             = string
    role_service_hostname = string
    managed_policy_arns   = list(string)
  })
  default = {
    role_name             = "mahjong_gateway_function_basic_exec_role"
    role_service_hostname = "lambda.amazonaws.com"
    managed_policy_arns   = ["arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"]
  }
}

variable "mahjong_gateway_function" {
  type = object({
    name        = string
    memory_size = number
    arch        = string
    cmd         = list(string)
  })
  default = {
    name        = "mahjong_gateway"
    memory_size = 128
    arch        = "x86_64"
    cmd         = []
  }
}
