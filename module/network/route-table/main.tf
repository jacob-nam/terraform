# Create Public Route Table
resource "aws_route_table" "public_routing_table" {
  vpc_id = var.vpc_id

  route {
    cidr_block = var.igw_destination_cidr
    gateway_id = var.igw_id
  }  

  tags = {
    Name = "rt-${var.user}-${var.project}-${var.stage}-pub"
  }
}

# Association Public Route Tables with public subnet
resource "aws_route_table_association" "public_routing_table_aassociation" {
  count          = length(var.pub_association_subnet)

  subnet_id      = var.pub_association_subnet[count.index]
  route_table_id = var.pub_association_route_table
}

# Create Private Route Table
resource "aws_route_table" "private_routing_table" {
  vpc_id = var.vpc_id

  route {
    cidr_block = var.ngw_destination_cidr
    gateway_id = var.ngw_id
  }  

  tags = {
    Name = "rt-${var.user}-${var.project}-${var.stage}-pri"
  }
}

# Association Private Route Tables with private subnet
resource "aws_route_table_association" "private_routing_table_aassociation" {
  count          = length(var.pri_association_subnet)

  subnet_id      = var.pri_association_subnet[count.index]
  route_table_id = var.pri_association_route_table
}







