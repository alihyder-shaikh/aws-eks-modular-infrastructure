variable "name" {
  description = "Name prefix for all resources"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "az_count" {
  description = "Number of Availability Zones to use (2 or 3)"
  type        = number
  default     = 2

  validation {
    condition     = var.az_count >= 2 && var.az_count <= 3
    error_message = "az_count must be 2 or 3."
  }
}

variable "tags" {
  description = "Common tags applied to all resources"
  type        = map(string)
  default     = {}
}

variable "nat_gateway_mode" {
  description = "'per_az' (production) or 'single' (cost-saving, lab only)"
  type        = string
  default     = "per_az"

  validation {
    condition     = contains(["per_az", "single"], var.nat_gateway_mode)
    error_message = "nat_gateway_mode must be 'per_az' or 'single'."
  }
}


variable "enable_s3_endpoint" {
  description = "Create a free S3 gateway endpoint on the private route tables"
  type        = bool
  default     = true
}

variable "interface_endpoints" {
  description = "Interface endpoint services by short name, e.g. [\"ecr.api\", \"ecr.dkr\", \"sts\"]. Each costs ~$7/month per AZ."
  type        = list(string)
  default     = []
}


variable "enable_flow_logs" {
  description = "Create VPC Flow Logs delivered to CloudWatch Logs"
  type        = bool
  default     = true
}

variable "flow_logs_retention_days" {
  description = "CloudWatch Logs retention for flow logs"
  type        = number
  default     = 7
}


variable "flow_logs_traffic_type" {
  description = "ACCEPT, REJECT or ALL. REJECT is much cheaper and is what you want when debugging."
  type        = string
  default     = "ALL"

  validation {
    condition     = contains(["ACCEPT", "REJECT", "ALL"], var.flow_logs_traffic_type)
    error_message = "flow_logs_traffic_type must be ACCEPT, REJECT or ALL."
  }
}