variable "region" {
  type    = string
  default = "us-east-1"
}

variable "project" {
  type    = string
  default = "eks-production-lab"
}

variable "alert_email" {
  description = "Email address for budget alerts"
  type        = string
}

variable "monthly_budget_usd" {
  type    = number
  default = 1
}