provider "aws" {
  version = "3.6.0"
  region  = "us-east-1"
  profile = "nko-terraform"
}

locals {
  user    = "nko"
  region  = "us1"
  stage   = "dev"
  name    = "${local.user}-${local.region}-${local.stage}"
}

resource "aws_s3_bucket" "bucket_terraform_state" {
  bucket = "${local.name}-bucket"
  acl    = "private"

  versioning {
    enabled = true
  }

  lifecycle_rule {
    id      = "default"
    enabled = true

    prefix = "/"

    noncurrent_version_expiration {
      days = 30
    }
  }

  tags = {
    Name        = "${local.name}-state"
    Description = "Terraform state files"
    Stage       = local.stage
  }
}

resource "aws_s3_bucket_public_access_block" "bucket_block_public_access" {
  bucket = aws_s3_bucket.bucket_terraform_state.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_dynamodb_table" "table_terraform_locks" {
  name           = "${local.name}-lock-table"
  hash_key       = "LockID"
  read_capacity  = 1
  write_capacity = 1

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name        = "${local.name}-terraform-locks"
    Description = "Terraform locks table"
    Stage       = local.stage
  }
}

# resource "aws_codecommit_repository" "repo_terragrunt_template" {
#   repository_name = "${local.project}-${local.user}-template"
#   description     = "${local.project} ${local.user}'s terragrunt template"
# }
