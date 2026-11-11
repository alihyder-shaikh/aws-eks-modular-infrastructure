variable "region" {
  type    = string
  default = "us-east-1"
}

variable "kubernetes_version" {
  type = string
}

variable "public_access_cidrs" {
  type = list(string)
}

variable "admin_principal_arn" {
  type = string
}