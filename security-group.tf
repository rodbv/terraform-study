resource "aws_security_group" "ssh-access" {
  name        = "ssh-access"
  description = "Allow SSH inbound traffic"

  ingress {
    description = "SSH from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["177.75.154.31/32"]
  }

  tags = {
    Name = "ssh"
  }
}
