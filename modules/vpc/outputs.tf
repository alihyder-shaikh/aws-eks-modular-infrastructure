output "vpc_id" {
  value = aws_vpc.this_vpc.id
}

output "vpc_cidr" {
  value = aws_vpc.this_vpc.cidr_block
}

output "public_subnet_ids" {
  value = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  value = aws_subnet.private[*].id
}

output "availability_zones" {
  value = local.azs
}

output "internet_gateway_id" {
  value = aws_internet_gateway.this_igw.id
}

output "public_route_table_id" {
  value = aws_route_table.public.id
}



output "nat_gateway_ids" {
  value = aws_nat_gateway.this_nat[*].id
}

output "nat_public_ips" {
  description = "Egress IPs of the NAT Gateways (useful for allow-listing)"
  value       = aws_eip.nat[*].public_ip
}

output "private_route_table_ids" {
  value = aws_route_table.private[*].id
}


output "s3_endpoint_id" {
  value = try(aws_vpc_endpoint.s3[0].id, null)
}

output "interface_endpoint_ids" {
  value = { for k, v in aws_vpc_endpoint.interface : k => v.id }
}


output "flow_logs_log_group_name" {
  value = try(aws_cloudwatch_log_group.flow_logs[0].name, null)
}