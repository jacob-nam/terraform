output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_ids" {
  value = module.vpc.public_subnet_ids
}

output "private_subnet_web_ids" {
  value = module.vpc.private_subnet_web_ids
}

output "private_subnet_eks_ids" {
  value = module.vpc.private_subnet_eks_ids
}

output "private_subnet_cache_ids" {
  value = module.vpc.private_subnet_cache_ids
}

output "private_subnet_db_ids" {
  value = module.vpc.private_subnet_db_ids
}