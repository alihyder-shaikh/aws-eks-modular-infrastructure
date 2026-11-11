# Only created when at least one interface endpoint is requested
resource "aws_security_group" "vpc_endpoints" {
  count = length(var.interface_endpoints) > 0 ? 1 : 0

  name        = "${var.name}-vpce-sg"
  description = "Allow HTTPS from within the VPC to interface endpoints"
  vpc_id      = aws_vpc.this_vpc.id

  tags = merge(var.tags, {
    Name = "${var.name}-vpce-sg"
  })
}

resource "aws_vpc_security_group_ingress_rule" "vpce_https" {
  count = length(var.interface_endpoints) > 0 ? 1 : 0

  security_group_id = aws_security_group.vpc_endpoints[0].id
  cidr_ipv4         = var.vpc_cidr
  from_port         = 443
  to_port           = 443
  ip_protocol       = "tcp"
  description       = "HTTPS from the VPC"
}