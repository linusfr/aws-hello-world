# s3-backend enabling both encryption and locking
terraform {
  backend "s3" {
    bucket         = "aws-hello-world-terraform"
    key            = "staging/services/webserver-cluster/terraform.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "aws-hello-world-terraform-locks"
    encrypt        = true
  }
}

provider "aws" {
  region = "eu-central-1"
}

module "webserver_cluster" {
  source = "../../../modules/services/webserver-cluster"
  cluster_name           = "webserver-cluster-staging"
  instance_type = "t2.micro"
  min_size      = 1
  max_size      = 2
}
