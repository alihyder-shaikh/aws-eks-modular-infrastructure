locals {
  nat_gateway_count = var.nat_gateway_mode == "single" ? 1 : var.az_count
}

resource "aws_eip" "nat" {
  count  = local.nat_gateway_count
  domain = "vpc"

  tags = merge(var.tags, {
    Name = "${var.name}-nat-eip-${local.azs[count.index]}"
  })

  depends_on = [aws_internet_gateway.this_igw]
}

# NAT Gateways live in PUBLIC subnets. In "single" mode there is one,
# in the first public subnet.
resource "aws_nat_gateway" "this_nat" {
  count = local.nat_gateway_count

  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = aws_subnet.public[count.index].id

  tags = merge(var.tags, {
    Name = "${var.name}-nat-${local.azs[count.index]}"
  })

  depends_on = [aws_internet_gateway.this_igw]
}