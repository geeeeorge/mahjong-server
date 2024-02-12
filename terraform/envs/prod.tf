variable "env_prod" {
  type    = string
  default = "prod"
}

module "mahjong_gateway_function_iam_policy_prod" {
  source = "../modules/iam/policy"

  env = var.env_prod
  policies = [
#    {
#      name        = var.mahjong_gateway_function_iam_policy.policy_name
#      description = var.mahjong_gateway_function_iam_policy.policy_description
#      statements = [
#        {
#          Effect = "Allow"
#          Action = var.mahjong_gateway_function_iam_policy.policy_statement_dynamodb_actions
#          Resource = [
#            module.mahjong_ddb_prod.ddb_arn,
#          ]
#        },
#      ]
#    }
  ]
}

module "mahjong_gateway_function_iam_role_prod" {
  source = "../modules/iam/role"

  env               = var.env_prod
  role_name         = var.mahjong_gateway_function_iam_role.role_name
  role_service_host = var.mahjong_gateway_function_iam_role.role_service_hostname
  policy_arns = concat(
    module.mahjong_gateway_function_iam_policy_prod.iam_policy_arns,
    var.mahjong_gateway_function_iam_role.managed_policy_arns,
  )
}

module "mahjong_gateway_function_prod" {
  source = "../modules/lambda"

  env           = var.env_prod
  function_name = var.mahjong_gateway_function.name
  ecr_uri       = module.mahjong_gateway_ecr.ecr_uri
  envs = [
    {
      name  = "ENV"
      value = var.env_prod
    },
    {
      name  = "MAHJONG_TABLE"
      value = ""  # TODO: module.mahjong_search_results_ddb_prod.ddb_name
    },
  ]
  iam_role_arn = module.mahjong_gateway_function_iam_role_prod.iam_role_arn
  memory_size  = var.mahjong_gateway_function.memory_size
  arch         = var.mahjong_gateway_function.arch
  cmd          = var.mahjong_gateway_function.cmd
}
