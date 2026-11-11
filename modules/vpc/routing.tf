# One private route table per AZ, regardless of NAT mode
resource "aws_route_table" "private" {
  count = var.az_count

  vpc_id = aws_vpc.this_vpc.id

  tags = merge(var.tags, {
    Name = "${var.name}-private-rt-${local.azs[count.index]}"
    Tier = "private"
  })
}

# single mode: every AZ routes to NAT[0]
# per_az mode: each AZ routes to its own NAT
resource "aws_route" "private_nat" {
  count = var.az_count

  route_table_id         = aws_route_table.private[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.this_nat[var.nat_gateway_mode == "single" ? 0 : count.index].id
}

resource "aws_route_table_association" "private" {
  count = var.az_count

  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private[count.index].id
}