
terraform {
  backend "s3" {
    bucket  = "tutorial.terraform.brad"
    key     = "stage/services/webserver-cluster/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}

provider "aws" {
  region = "us-east-1"
}

module "webserver-cluster" {
  source = "git::https://github.com/bradAnderson58/terraform_modules.git//services/webserver-cluster?ref=v0.0.1"

  cluster_name           = "webserver-stage"
  db_remote_state_bucket = "tutorial.terraform.brad"
  db_remote_state_key    = "stage/data-storage/mysql/terraform.tfstate"

  instance_type      = "t2.micro"
  min_size           = 2
  max_size           = 2
  enable_autoscaling = false
}

resource "aws_security_group_rule" "allow_testing_inbound" {
  type              = "ingress"
  security_group_id = "${module.webserver-cluster.elb_security_group_id}"

  from_port   = 12345
  to_port     = 12345
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}
