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
    onepassword = {
      source  = "1Password/onepassword"
      version = "~> 2.1"
    }
    b2 = {
      source  = "Backblaze/b2"
      version = "~> 0.10"
    }
  }

  backend "s3" {
    bucket  = "coneill-opentofu-state"
    key     = "homelab/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}

# 1Password provider configuration
provider "onepassword" {
  account = "6GO3NBF2PRCY3NAW6SN2CG6I2U"
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
  api_key = local.vultr_api_key
}

provider "b2" {
  application_key_id = local.b2_application_key_id
  application_key    = local.b2_application_key
}

module "dns" {
  source = "./modules/dns"
}
