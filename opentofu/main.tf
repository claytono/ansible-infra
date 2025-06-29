terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
    vultr = {
      source  = "vultr/vultr"
      version = "~> 2.15"
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

provider "vultr" {
  api_key = var.vultr_api_key
}

module "dns" {
  source = "./modules/dns"
}
