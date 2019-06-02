
terraform {
  backend "s3" {
    bucket  = "tutorial.terraform.brad"
    key     = "prod/data-storage/mysql/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}

provider "aws" {
  region = "us-east-1"
}

module "mysql" {
  source = "git::https://github.com/bradAnderson58/terraform_modules.git//data-storage/mysql?ref=v0.0.1"

  db_password = "${var.db_password}"
  environment = "prod"
}
