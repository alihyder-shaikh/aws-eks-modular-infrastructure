output "cluster_name" {
  value = aws_eks_cluster.this_cluster.name
}

output "cluster_arn" {
  value = aws_eks_cluster.this_cluster.arn
}

output "cluster_endpoint" {
  value = aws_eks_cluster.this_cluster.endpoint
}

output "cluster_certificate_authority_data" {
  value = aws_eks_cluster.this_cluster.certificate_authority[0].data
}

output "cluster_security_group_id" {
  description = "EKS-managed security group attached to the control plane and managed nodes"
  value       = aws_eks_cluster.this_cluster.vpc_config[0].cluster_security_group_id
}

output "oidc_issuer" {
  value = aws_eks_cluster.this_cluster.identity[0].oidc[0].issuer
}