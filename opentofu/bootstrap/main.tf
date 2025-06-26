terraform {
  required_version = ">= 1.6"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# trivy:ignore:AVD-AWS-0089 - S3 access logging not needed for Terraform state bucket
resource "aws_s3_bucket" "terraform_state" {
  bucket = "coneill-opentofu-state"
}

resource "aws_s3_bucket_versioning" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id
  versioning_configuration {
    status = "Enabled"
  }
}

# trivy:ignore:AVD-AWS-0132 - AWS-managed encryption sufficient for Terraform state bucket
resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_lifecycle_configuration" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id

  rule {
    id     = "cleanup_old_versions"
    status = "Enabled"

    filter {
      prefix = "" # Apply to all objects
    }

    noncurrent_version_expiration {
      noncurrent_days = 90
    }

    # Also clean up incomplete multipart uploads (good practice)
    abort_incomplete_multipart_upload {
      days_after_initiation = 7
    }
  }
}
