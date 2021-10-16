variable "amis" {
  type = map(string)
  default = {
    "us-east-1" = "ami-02e136e904f3da870"
    "us-east-2" = "ami-074cce78125f09d61"
  }
}


variable "cdir-access" {
  type    = list(any)
  default = ["186.222.58.148/32"]
}

variable "ssh-key-name" {
  default = "terraform-aws-key"
}

variable "micro" {
  default = "t2.micro"
}
