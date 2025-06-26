terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket  = "coneill-opentofu-state"
    key     = "homelab/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}

provider "aws" {
  region = "us-west-2"

  default_tags {
    tags = {
      ManagedBy = "opentofu"
    }
  }
}

module "dns" {
  source = "./modules/dns"
}
