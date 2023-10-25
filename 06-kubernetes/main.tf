# s3-backend enabling both encryption and locking
terraform {
  backend "s3" {
    bucket         = "aws-hello-world-terraform"
    key            = "terraform-example/terraform.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "aws-hello-world-terraform-locks"
    encrypt        = true
  }
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks_cluster.cluster_name
}

# Create an EKS cluster
module "eks_cluster" {
  source = "./modules/eks-cluster"

  name = var.cluster_name

  min_size     = 1
  max_size     = 2
  desired_size = 1

  # Due to the way EKS works with ENIs, t3.small is the smallest
  # instance type that can be used for worker nodes. If you try
  # something smaller like t2.micro, which only has 4 ENIs,
  # they'll all be used up by system services (e.g., kube-proxy)
  # and you won't be able to deploy your own Pods.
  instance_types = ["t3.small"]
}

# Deploy a simple web app into the EKS cluster
module "simple_webapp" {
  source = "./modules/k8s-app"

  name = var.app_name

  image          = "training/webapp"
  replicas       = 2
  container_port = 5000

  environment_variables = {
    PROVIDER = "Terraform"
  }

  # Only deploy the app after the cluster has been deployed
  depends_on = [module.eks_cluster]
}
