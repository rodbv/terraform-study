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

provider "aws" {
  alias   = "us-east-2"
  profile = "terraform"
  region  = "us-east-2"
}

resource "aws_instance" "dev" {
  count         = 3
  ami           = var.amis["us-east-1"]
  instance_type = var.micro
  key_name      = var.ssh-key-name
  tags = {
    "Name" = "dev-${count.index}"
  }
  vpc_security_group_ids = ["${aws_security_group.ssh-access.id}"]
}

resource "aws_instance" "dev-4" {
  ami           = var.amis["us-east-1"]
  instance_type = var.micro
  key_name      = var.ssh-key-name
  tags = {
    "Name" = "dev-4"
  }
  vpc_security_group_ids = ["${aws_security_group.ssh-access.id}"]
  depends_on = [
    aws_s3_bucket.dev-4
  ]
}

resource "aws_instance" "dev-6" {
  provider      = aws.us-east-2
  ami           = var.amis["us-east-2"]
  instance_type = var.micro
  key_name      = var.ssh-key-name
  tags = {
    "Name" = "dev-6"
  }
  vpc_security_group_ids = ["${aws_security_group.ssh-access-us-east-2.id}"]
}

resource "aws_s3_bucket" "dev-4" {
  bucket = "dev4-test-bucket"
  acl    = "private"

  tags = {
    Name = "dev4-test-bucket"
  }
}
