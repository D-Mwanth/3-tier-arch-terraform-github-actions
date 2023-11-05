# Isolating provisioning of the backend ensures upon terraform destroy action on the
# infrustructure code the backend bucket does not endup deleted in the process
terraform {
  backend "s3" {
    bucket         = "mwan-daniel-tf-state-backend"
    key            = "tf-infra/terraform.tfstate"
    region         = "eu-north-1"
    dynamodb_table = "terraform-state-locking"
    encrypt        = true
  }

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

# state storage module
module "tf-state" {
  source      = "./modules/tf-state"
  bucket_name = "mwan-daniel-tf-state-backend"
}
