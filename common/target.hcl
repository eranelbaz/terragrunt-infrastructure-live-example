locals {
  # Non-prod specific configurations
  environment_type = "non-production"
  
  # Non-prod specific tags
  environment_tags = {
    Environment = "non-prod"
    CostCenter   = "development"
  }
}
