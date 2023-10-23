terraform {
  required_version = ">= 1.5.7"

  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.22.0"
    }
  }

  backend "s3" {
    key            = "terraform-workspaces/stage/data-stores/mysql/terraform.tfstate"
    bucket         = "aws-hello-world-terraform-state-bucket"
    region         = "eu-central-1"
    dynamodb_table = "aws-hello-world-terraform-state-bucket-locks"
    encrypt        = true
  }
}

provider "aws" {
  region = "eu-central-1"
}

resource "aws_db_instance" "example" {
  identifier_prefix   = "terraform-up-and-running"
  engine              = "mysql"
  allocated_storage   = 10
  instance_class      = "db.t2.micro"
  skip_final_snapshot = true

  db_name             = var.db_name

  username = var.db_username
  password = var.db_password
}
