terraform {
  backend "s3" {
    encrypt        = true
    bucket         = "nko-us1-dev-bucket"
    dynamodb_table = "nko-us1-dev-lock-table"
    key            = "compute/server/terraform.tfstate"
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

module "ec2_instance" {
  source  = "../../../module/compute"

  # ami                    = var.aml2
  # instance_type          = var.bastion_type

  user    = "nko"
  project = "terraform" 
  stage   = "dev"
}