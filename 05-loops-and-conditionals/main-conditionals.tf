# module "webserver_cluster" {
#   source = "./modules/webserver-cluster"
#   cluster_name  = "webserver-cluster-loops"

#   enable_autoscaling = true
# }

module user {
  source = "./modules/user"
  user_name = "bob"
  user_rw_cloudwatch = true
}

resource "random_integer" "num_instances" {
  min = 1
  max = 3
}

resource "aws_instance" "example_3" {
  count         = random_integer.num_instances.result
  ami           = "ami-06dd92ecc74fdfb36"
  instance_type = "t2.micro"
}

# instead of running tf state mv
# moved {
#   to   = random_integer.num_instances
#   from = random_integer.random
# }
