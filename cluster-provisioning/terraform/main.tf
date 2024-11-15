terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.0"
    }
  }
}

provider "aws" {
  region = "eu-west-2"
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}



module "K8sInfra" {
  source = "./modules/eks"
}

module "IngressController" {
  source = "./modules/ingress-controller"
}

