variable "env" {
  description = "Env (dev or prod)"
  type        = string
}

variable "policies" {
  description = "Policies"
  type = list(object({
    name        = string
    description = string
    statements = list(object({
      Effect   = string
      Action   = list(string)
      Resource = list(string)
    }))
  }))
}
