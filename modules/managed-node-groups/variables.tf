variable "cluster_name" {
  type = string
}

variable "subnet_ids" {
  description = "Private subnets for the nodes"
  type        = list(string)
}

variable "node_groups" {
  description = "Managed node groups keyed by name"
  type = map(object({
    instance_types = optional(list(string), ["t3.medium"])
    capacity_type  = optional(string, "ON_DEMAND")
    ami_type       = optional(string, "AL2023_x86_64_STANDARD")
    min_size       = optional(number, 2)
    max_size       = optional(number, 3)
    desired_size   = optional(number, 2)
    disk_size_gb   = optional(number, 30)
    labels         = optional(map(string), {})
  }))
}

variable "tags" {
  type    = map(string)
  default = {}
}