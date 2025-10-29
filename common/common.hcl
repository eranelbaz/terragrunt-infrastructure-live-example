locals {
  # Base source URL for Terraform modules
 
  # Common tags for all resources
  common_tags = {
    Environment = "non-prod"
    ManagedBy   = "terragrunt"
    Project     = "infrastructure-live-example"
  }
}
