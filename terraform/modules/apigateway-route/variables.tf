variable "gateway_id" {
  description = "API Gateway ID"
  type        = string
}

variable "invoke_arn" {
  description = "Invoke arn of lambda function"
  type        = string
}

variable "route_key" {
  description = "Route Key"
  type        = string
}
