output "vpc_id" {
  value = module.vpc.id
}

output "public_subnet_ids" {
  value = module.public_subnet.ids
}

output "private_subnet_web_ids" {
  value = module.private_subnet_web.ids
}

output "private_subnet_eks_ids" {
  value = module.private_subnet_eks.ids
}

output "private_subnet_cache_ids" {
  value = module.private_subnet_cache.ids
}

output "private_subnet_db_ids" {
  value = module.private_subnet_db.ids
}

output "igw_id" {
  value = module.igw.internet_gateway_id
}

output "ngw_id" {
  value = module.nat_gw.nat_gateway_id
}

output "rt_id" {
  value = module.route_table.route_table_id
}