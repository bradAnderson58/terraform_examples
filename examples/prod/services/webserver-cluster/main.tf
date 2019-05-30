
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

  instance_type = "t2.small"
  min_size      = 2
  max_size      = 10
}

resource "aws_autoscaling_schedule" "scale_out_during_business_hours" {
  scheduled_action_name = "scale-out-business-hours"
  min_size              = 2
  max_size              = 10
  desired_capacity      = 10
  recurrence            = "0 9 * * *"

  autoscaling_group_name = "${module.webserver-cluster.asg_name}"
}

resource "aws_autoscaling_schedule" "scale_in_at_night" {
  scheduled_action_name = "scale-in-night"
  min_size              = 2
  max_size              = 10
  desired_capacity      = 2
  recurrence            = "0 17 * * *"

  autoscaling_group_name = "${module.webserver-cluster.asg_name}"
}
