
terraform {
  backend "s3" {
    bucket  = "tutorial.terraform.brad"
    key     = "stage/data-storage/mysql/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}

provider "aws" {
  region = "us-east-1"
}

module "mysql" {
  source = "../../../modules/data-storage/mysql"

  db_password = "${var.db_password}"
  environment = "stage"
}