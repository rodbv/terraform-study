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
  ami           = "ami-02e136e904f3da870"
  instance_type = "t2.micro"
  key_name      = "terraform-aws-key"
  tags = {
    "Name" = "dev-${count.index}"
  }
  vpc_security_group_ids = ["${aws_security_group.ssh-access.id}"]
}

resource "aws_instance" "dev-4" {
  ami           = "ami-02e136e904f3da870"
  instance_type = "t2.micro"
  key_name      = "terraform-aws-key"
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
  ami           = "ami-074cce78125f09d61"
  instance_type = "t2.micro"
  key_name      = "terraform-aws-key"
  tags = {
    "Name" = "dev-6"
  }
  vpc_security_group_ids = ["${aws_security_group.ssh-access-us-east-2.id}"]
  depends_on = [
    aws_dynamodb_table.game-scores-table
  ]
}

resource "aws_s3_bucket" "dev-4" {
  bucket = "dev4-test-bucket"
  acl    = "private"

  tags = {
    Name = "dev4-test-bucket"
  }
}
