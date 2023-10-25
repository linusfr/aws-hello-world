# count
# resource "aws_iam_user" "example" {
#   count = 3
#   name  = "neo.${count.index}"
# }

# count + array
# resource "aws_iam_user" "example" {
#   count = length(var.user_names)
#   name  = var.user_names[count.index]
# }

# count + module
# module user {
#   source = "./modules/user"
#   count     = length(var.user_names)
#   user_name = var.user_names[count.index]
# }
