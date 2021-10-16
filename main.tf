terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.63"
    }
  }
}

provider "aws" {
  profile = "terraform"
  region  = "us-east-1"
}

resource "aws_instance" "dev" {
  count         = 3
  ami           = "ami-02e136e904f3da870"
  instance_type = "t2.micro"
  key_name      = "terraform-aws-key"
  tags = {
    "Name" = "dev-${count.index}"
  }
  vpc_security_group_ids = ["${aws_security_group.ssh-access.id}"]
}

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

resource "aws_s3_bucket" "dev-bucket" {
  bucket = "my-tf-test-bucket"
  acl    = "private"

  tags = {
    Name        = "Dev bucket"
    Environment = "Dev"
  }
}
