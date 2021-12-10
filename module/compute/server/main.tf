resource "aws_instance" "pub_ec2" {
  ami           = var.ami
  instance_type = var.instance_type

  tags = {
    Name = "${var.user}-${var.project}-${var.stage}-bastion"
  }
}