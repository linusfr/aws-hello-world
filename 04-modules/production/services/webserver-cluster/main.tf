# s3-backend enabling both encryption and locking
terraform {
  backend "s3" {
    bucket         = "aws-hello-world-terraform"
    key            = "production/services/webserver-cluster/terraform.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "aws-hello-world-terraform-locks"
    encrypt        = true
  }
}

provider "aws" {
  region = "eu-central-1"
}

locals {
  min_size = 1
  max_size = 2
}

module "webserver_cluster" {
  source = "../../../modules/services/webserver-cluster"
  cluster_name           = "webserver-cluster-production"
  instance_type = "t2.micro"
  min_size      = local.min_size
  max_size      = local.max_size
}

resource "aws_autoscaling_schedule" "scale_out_in_morning" {
  scheduled_action_name = "scale-out-during-business-hours"
  min_size      = local.min_size
  max_size      = local.max_size
  desired_capacity      = 2
  recurrence            = "0 9 * * *"

  autoscaling_group_name = module.webserver_cluster.asg_name
}

resource "aws_autoscaling_schedule" "scale_in_at_night" {
  scheduled_action_name = "scale-in-at-night"
  min_size      = local.min_size
  max_size      = local.max_size
  desired_capacity      = 1
  recurrence            = "0 17 * * *"

  autoscaling_group_name = module.webserver_cluster.asg_name
}

resource "aws_security_group_rule" "allow_testing_inbound" {
  type              = "ingress"
  security_group_id = module.webserver_cluster.alb_security_group_id

  from_port   = 12345
  to_port     = 12345
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}
