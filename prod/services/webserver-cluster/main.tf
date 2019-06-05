
terraform {
  backend "s3" {
    bucket  = "tutorial.terraform.brad"
    key     = "prod/services/webserver-cluster/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}

provider "aws" {
  region = "us-east-1"
}

module "webserver-cluster" {
  source = "git::https://github.com/bradAnderson58/terraform_modules.git//services/webserver-cluster?ref=v0.0.1"

  cluster_name = "webserver-prod"
  db_remote_state_bucket = "tutorial.terraform.brad"
  db_remote_state_key = "prod/data-storage/mysql/terraform.tfstate"

  instance_type      = "t2.small"
  min_size           = 2
  max_size           = 10
  enable_autoscaling = true
}