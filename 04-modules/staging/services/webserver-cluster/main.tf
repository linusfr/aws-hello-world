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

module "webserver_cluster_02" {
  source = "../../../modules/services/webserver-cluster"
  cluster_name           = "webserver-cluster-staging-02"
  instance_type = "t2.micro"
  min_size      = 1
  max_size      = 2
}
