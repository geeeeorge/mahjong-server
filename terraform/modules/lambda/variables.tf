variable "env" {
  description = "Env (dev or prod)"
  type        = string
}

variable "function_name" {
  description = "Name of the function"
  type        = string
}

variable "iam_role_arn" {
  description = "Arn of IAM Role to grant on the function"
  type        = string
}

variable "ecr_uri" {
  description = "URI of ECR for the function"
  type        = string
}

variable "memory_size" {
  description = "Size of the memory of the function"
  type        = number
}

variable "envs" {
  description = "Envs of the function"
  type = list(object({
    name  = string
    value = string
  }))
}

variable "arch" {
  description = "Architecture of Docker Image"
  type        = string
}
