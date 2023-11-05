terraform {
  # set required backend  
  backend "s3" {
    bucket         = "mwan-daniel-tf-state-backend"
    key            = "tf-infra/terraform.tfstate"
    region         = "eu-north-1"
    dynamodb_table = "terraform-state-locking"
    encrypt        = true
  }
  
  # delcare required provider and there version
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.24.0"
    }
  }
}

# provider
provider "aws" {
  region = "eu-north-1"
}

# vpc module
module "vpc-infra" {
  source = "./modules/vpc"

  # VPC Input Vars
  vpc_cidr             = local.vpc_cidr
  availability_zones   = local.availability_zones
  public_subnet_cidrs  = local.public_subnet_cidrs
  private_subnet_cidrs = local.private_subnet_cidrs
}