variable "env" {
  description = "Env (dev or prod)"
  type        = string
}

variable "role_name" {
  description = "Name of Role"
  type        = string
}

variable "role_service_host" {
  description = "Hostname of Service"
  type        = string
}

variable "policy_arns" {
  description = "Arns of policies"
  type        = list(string)
}
