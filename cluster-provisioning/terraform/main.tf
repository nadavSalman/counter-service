provider "aws" {
  region = "eu-west-2"

}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}



module "K8sInfra" {
  source = "./modules/eks"
}
