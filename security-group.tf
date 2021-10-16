resource "aws_security_group" "ssh-access" {
  name        = "ssh-access"
  description = "Allow SSH inbound traffic"

  ingress {
    description = "SSH from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["186.222.58.148/32"]
  }

  tags = {
    Name = "ssh"
  }
}

resource "aws_security_group" "ssh-access-us-east-2" {
  provider    = aws.us-east-2
  name        = "ssh-access"
  description = "Allow SSH inbound traffic"

  ingress {
    description = "SSH from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["186.222.58.148/32"]
  }

  tags = {
    Name = "ssh"
  }
}
