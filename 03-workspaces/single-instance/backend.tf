# Partial configuration. The other settings (e.g., bucket, region)
# will be passed in from a file via -backend-config arguments to
# 'terraform init -backend-config=backend.hcl'
terraform {
  backend "s3" {
    key = "terraform-workspaces/terraform.tfstate"
  }
}
