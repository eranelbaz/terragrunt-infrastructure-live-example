locals {
  # Base source URL for Terraform modules
  base_source_url = "${dirname(find_in_parent_folders("root.hcl"))}/modules/dummy-s3"
  
  # Common tags for all resources
  common_tags = {
    Environment = "non-prod"
    ManagedBy   = "terragrunt"
    Project     = "infrastructure-live-example"
  }
}
