# s3-backend enabling both encryption and locking
terraform {
  backend "s3" {
    bucket         = "aws-hello-world-terraform"
    key            = "loops-and-conditionals/terraform.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "aws-hello-world-terraform-locks"
    encrypt        = true
  }
}

provider "aws" {
  region = "eu-central-1"
}

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
