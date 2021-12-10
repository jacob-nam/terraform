terraform {
  backend "s3" {
    encrypt        = true
    bucket         = "nko-us1-dev-bucket"
    dynamodb_table = "nko-us1-dev-lock-table"
    key            = "network/terraform.tfstate"
    profile        = "nko-terraform"
    region         = "us-east-1" 
  }

  required_version = ">= 0.12.0"
}

provider "aws" {
  version = "3.6.0"
  region  = "us-east-1"
  profile = "nko-terraform"
}

module "vpc" {
  source = "../../../module/network"

  vpc_cidr                   = "30.0.0.0/16"
  public_subnet_cidrs        = [ "30.0.10.0/24", "30.0.20.0/24" ]
  private_subnet_web_cidrs   = [ "30.0.30.0/24", "30.0.40.0/24" ]
  private_subnet_eks_cidrs   = [ "30.0.50.0/24", "30.0.60.0/24" ]
  private_subnet_cache_cidrs = [ "30.0.70.0/24", "30.0.80.0/24" ]
  private_subnet_db_cidrs    = [ "30.0.90.0/24", "30.0.100.0/24" ]

  availability_zones         = [ "us-east-1a", "us-east-1c" ]

  user    = "nko"
  project = "terraform" 
  stage   = "dev"
}
