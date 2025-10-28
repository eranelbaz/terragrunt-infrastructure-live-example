# Dummy S3 module with null resources for testing Terragrunt
terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "~> 3.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}

# Local values
locals {
  bucket_name = var.bucket_name != "" ? var.bucket_name : "dummy-bucket-${var.account_id}-${var.region}-${random_string.suffix.result}"
}

# Random string for unique naming
resource "random_string" "suffix" {
  length  = 8
  special = false
  upper   = false
}

# Dummy S3 bucket using null resource (simulated)
resource "null_resource" "dummy_s3_bucket" {
  triggers = {
    bucket_name = local.bucket_name
    region      = var.region
    account_id  = var.account_id
    environment = var.environment
  }

  provisioner "local-exec" {
    command = "echo 'Creating dummy S3 bucket: ${local.bucket_name} in region: ${var.region} for account: ${var.account_id}'"
  }
}

# Dummy S3 bucket policy using null resource
resource "null_resource" "dummy_s3_policy" {
  depends_on = [null_resource.dummy_s3_bucket]

  triggers = {
    bucket_name = local.bucket_name
    region      = var.region
    account_id  = var.account_id
  }

  provisioner "local-exec" {
    command = "echo 'Creating dummy S3 bucket policy for: ${local.bucket_name}'"
  }
}

# Dummy CloudWatch alarm using null resource
resource "null_resource" "dummy_cloudwatch_alarm" {
  depends_on = [null_resource.dummy_s3_bucket]

  triggers = {
    bucket_name = local.bucket_name
    region      = var.region
    account_id  = var.account_id
  }

  provisioner "local-exec" {
    command = "echo 'Creating dummy CloudWatch alarm for: ${local.bucket_name}'"
  }
}
