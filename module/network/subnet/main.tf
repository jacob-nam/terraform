resource "aws_subnet" "subnet" {
  count             = length(var.subnet_cidr)

  vpc_id            = var.vpc_id
  cidr_block        = var.subnet_cidr[count.index]
  availability_zone = var.availability_zones[count.index]

  tags = {
    Name = "sub-${var.user}-${var.project}-${var.service}-${var.stage}"
  }
}
