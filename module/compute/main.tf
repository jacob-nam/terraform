module "ec2_instance" {
  source = "./server"

  ami                    = "ami-0ed9277fb7eb570c9"
  instance_type          = "t3.medium"

  user    = var.user
  project = var.project
  stage   = var.stage
}