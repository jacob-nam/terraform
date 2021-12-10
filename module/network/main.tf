# Create VPC
module "vpc" {
  source = "./vpc"

  vpc_cidr = var.vpc_cidr

  user    = var.user
  project = var.project
  stage   = var.stage
}

# Create Subnet
module "public_subnet" {
  source = "./subnet"

  vpc_id             = module.vpc.id
  subnet_cidr        = var.public_subnet_cidrs
  availability_zones = var.availability_zones

  user    = var.user
  project = var.project
  service = "public"
  stage   = var.stage
}

module "private_subnet_web" {
  source = "./subnet"

  vpc_id             = module.vpc.id
  subnet_cidr        = var.private_subnet_web_cidrs
  availability_zones = var.availability_zones

  user    = var.user
  project = var.project
  service = "web"
  stage   = var.stage
}

module "private_subnet_eks" {
  source = "./subnet"

  vpc_id             = module.vpc.id
  subnet_cidr        = var.private_subnet_eks_cidrs
  availability_zones = var.availability_zones

  user    = var.user
  project = var.project
  service = "eks"
  stage   = var.stage
}

module "private_subnet_cache" {
  source = "./subnet"

  vpc_id             = module.vpc.id
  subnet_cidr        = var.private_subnet_cache_cidrs
  availability_zones = var.availability_zones

  user    = var.user
  project = var.project
  service = "cache"
  stage   = var.stage
}

module "private_subnet_db" {
  source = "./subnet"

  vpc_id             = module.vpc.id
  subnet_cidr        = var.private_subnet_db_cidrs
  availability_zones = var.availability_zones

  user    = var.user
  project = var.project
  service = "db"
  stage   = var.stage
}

# Create igw
module "igw" {
  source = "./igw"

  vpc_id             = module.vpc.id

  user    = var.user
  project = var.project
  stage   = var.stage  
}

# Create NAT Gateway
module "nat_gw" {
  source = "./ngw"

  nat_subnet_id      = module.public_subnet.ids

  user    = var.user
  project = var.project
  stage   = var.stage
}

# Create & Associate Public Route table
module "route_table" {
  source = "./route-table"

  vpc_id               = module.vpc.id

  igw_destination_cidr = "0.0.0.0/0"
  igw_id               = module.igw.internet_gateway_id
  pub_association_subnet   = module.public_subnet.ids
  pub_association_route_table = module.route_table.route_table_id


  ngw_destination_cidr = "0.0.0.0/0"
  ngw_id               = module.nat_gw.nat_gateway_id
  # pri_association_subnet = module.private_subnet_web.ids
  pri_association_subnet = "${concat(
    module.private_subnet_web.ids,
    module.private_subnet_eks.ids,
    module.private_subnet_cache.ids,
    module.private_subnet_db.ids,
  )}"
  pri_association_route_table = module.route_table.private_route_table_id

  

  user    = var.user
  project = var.project
  stage   = var.stage  
}






