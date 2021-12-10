# variable "aml2" {
#     value = "ami-0ed9277fb7eb570c9"
# }

# variable "bastion_type" {
#     value = "t3.medium"
# }

data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    encrypt = true
    bucket = "nko-us1-dev-bucket"
    dynamodb_table = "nko-us1-dev-lock-table"
    key = "network/terraform.tfstate"
    profile        = "nko-terraform"
    region = "us-east-1"
  }
}

data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = {
    bucket  = var.terraform_state_bucket
    key     = var.vpc_terraform_state_path
    region  = var.aws_region
    profile = var.aws_profile    
  }
}

