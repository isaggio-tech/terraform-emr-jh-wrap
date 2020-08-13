resource "tls_private_key" "instance_access_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name   = "${var.name}-instance-ssh-key"
  public_key = tls_private_key.instance_access_key.public_key_openssh
}