variable "vpc_cidr" {}

variable "public_subnet_cidrs" {
  type = list
}

variable "private_subnet_web_cidrs" {
  type = list
}

variable "private_subnet_eks_cidrs" {
  type = list
}

variable "private_subnet_cache_cidrs" {
  type = list
}

variable "private_subnet_db_cidrs" {
  type = list
}

variable "availability_zones" {
  type = list
}
