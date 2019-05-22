
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


resource "aws_db_instance" "example" {
  engine              = "mysql"
  allocated_storage   = 10
  instance_class      = "db.t2.micro"
  name                = "example_database"
  username            = "admin"
  password            = "${var.db_password}"
  skip_final_snapshot = true
}