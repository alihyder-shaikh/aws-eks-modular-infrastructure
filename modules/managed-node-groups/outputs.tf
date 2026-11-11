output "node_role_arn" {
  value = aws_iam_role.node.arn
}

output "node_role_name" {
  value = aws_iam_role.node.name
}

output "node_group_names" {
  value = [for ng in aws_eks_node_group.this : ng.node_group_name]
}