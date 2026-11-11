terraform {
  required_version = ">= 1.11.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket       = "eks-production-lab-tfstate-223532248615-us-east-1" # your bucket
    key          = "lab/20-eks/terraform.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true
  }
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

# Read the VPC outputs from the network state
data "terraform_remote_state" "network" {
  backend = "s3"

  config = {
    bucket = "eks-production-lab-tfstate-223532248615-us-east-1" # your bucket
    key    = "lab/10-network/terraform.tfstate"
    region = "us-east-1"
  }
}

module "eks_cluster" {
  source = "../../modules/eks-cluster"

  name                         = "eks-lab"
  kubernetes_version           = var.kubernetes_version
  subnet_ids                   = data.terraform_remote_state.network.outputs.private_subnet_ids
  endpoint_public_access_cidrs = var.public_access_cidrs
  admin_principal_arn          = var.admin_principal_arn
}


module "managed_node_groups" {
  source = "../../modules/managed-node-groups"

  cluster_name = module.eks_cluster.cluster_name
  subnet_ids   = data.terraform_remote_state.network.outputs.private_subnet_ids

  node_groups = {
    system = {
      instance_types = ["t3.medium"]
      min_size       = 2
      max_size       = 3
      desired_size   = 2
      labels = {
        role = "system"
      }
    }
  }
}