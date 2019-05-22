
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
  source = "../../../modules/services/webserver-cluster"

  cluster_name = "webserver-prod"
  db_remote_state_bucket = "tutorial.terraform.brad"
  db_remote_state_key = "prod/data-storage/mysql/terraform.tfstate"
}
