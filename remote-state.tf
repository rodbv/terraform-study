terraform {
  backend "remote" {
    organization = "rodrigo-org"

    workspaces {
      name = "aws-terraform-study"
    }
  }
}
