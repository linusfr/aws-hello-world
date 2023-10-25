# backend.hcl
bucket         = "aws-hello-world-terraform-state-bucket"
region         = "eu-central-1"
dynamodb_table = "aws-hello-world-terraform-state-bucket-locks"
encrypt        = true
