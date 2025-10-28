# Outputs for the dummy S3 module
output "bucket_name" {
  description = "Name of the dummy S3 bucket"
  value       = local.bucket_name
}

output "region" {
  description = "AWS region"
  value       = var.region
}

output "account_id" {
  description = "AWS account ID"
  value       = var.account_id
}

output "environment" {
  description = "Environment name"
  value       = var.environment
}

output "random_suffix" {
  description = "Random suffix used for unique naming"
  value       = random_string.suffix.result
}
