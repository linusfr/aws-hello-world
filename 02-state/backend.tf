# s3-backend enabling both encryption and locking
terraform {
  backend "s3" {
    bucket         = "aws-hello-world-terraform-state-bucket"
    key            = "global/s3/terraform.tfstate"
    region         = "eu-central-1"

    dynamodb_table = "aws-hello-world-terraform-state-bucket-locks"
    encrypt        = true
  }
}

##################
# bucket resources
# required for the
# backend
##################

resource "aws_s3_bucket" "terraform_state" {
  bucket = local.tf-state-bucket-name

  # Prevent accidental deletion of this S3 bucket
  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_bucket_versioning" "enabled" {
  bucket = aws_s3_bucket.terraform_state.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "default" {
  bucket = aws_s3_bucket.terraform_state.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# making sure that no-one exposes the bucket accidentally
resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket                  = aws_s3_bucket.terraform_state.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_dynamodb_table" "terraform_locks" {
  name         = "${local.tf-state-bucket-name}-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}

