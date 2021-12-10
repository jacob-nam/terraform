# Create EIP
resource "aws_eip" "nat_eip" {

  tags = {
    Name = "ngw-eip-${var.user}-${var.project}-${var.stage}"
  }
}

# Create NAT Gateway 
resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = var.nat_subnet_id[0]

  tags = {
    Name = "ngw-${var.user}-${var.project}-${var.stage}"
  }
}