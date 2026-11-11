variable "name" {
  description = "EKS cluster name"
  type        = string
}

variable "kubernetes_version" {
  description = "Kubernetes version, e.g. \"1.34\""
  type        = string
}

variable "subnet_ids" {
  description = "Private subnets for the control plane ENIs"
  type        = list(string)
}

variable "endpoint_public_access_cidrs" {
  description = "CIDRs allowed to reach the public API endpoint, e.g. [\"203.0.113.10/32\"]"
  type        = list(string)
}

variable "admin_principal_arn" {
  description = "IAM user or role ARN that gets cluster-admin"
  type        = string
}

variable "enabled_log_types" {
  type    = list(string)
  default = ["api", "audit", "authenticator"]
}

variable "log_retention_days" {
  type    = number
  default = 7
}

variable "tags" {
  type    = map(string)
  default = {}
}