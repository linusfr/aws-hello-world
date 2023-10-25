# for + array converted to set
# resource "aws_iam_user" "example" {
#   for_each = toset(var.user_names)
#   name     = each.value
# }

# for + module
# module "user" {
#   source = "./modules/user"
#   for_each  = toset(var.user_names)
#   user_name = each.value
# }

# module "webserver_cluster" {
#   source = "./modules/webserver-cluster"
#   cluster_name  = "webserver-cluster-loops"

#   custom_tags = {
#     Owner     = "team-foo"
#     ManagedBy = "terraform"
#   }
# }
