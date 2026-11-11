terraform {
  required_version = ">= 1.11.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket       = "eks-production-lab-tfstate-223532248615-us-east-1" # use your bucket name
    key          = "lab/10-network/terraform.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true
  }
}

variable "region" {
  type    = string
  default = "us-east-1" # change to your preferred region
}

provider "aws" {
  region = var.region

  default_tags {
    tags = {
      Project     = "eks-production-lab"
      Environment = "lab"
      ManagedBy   = "terraform"
    }
  }
}

module "vpc" {
  source = "../../modules/vpc" # keep your working path

  name             = "eks-lab"
  vpc_cidr         = "10.0.0.0/16"
  az_count         = 2
  nat_gateway_mode = "single"

  enable_s3_endpoint  = true
  interface_endpoints = []

  enable_flow_logs         = true
  flow_logs_retention_days = 7
  flow_logs_traffic_type   = "ALL"
}