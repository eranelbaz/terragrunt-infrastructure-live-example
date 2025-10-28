# Variables for the dummy S3 module
variable "region" {
  description = "AWS region"
  type        = string
}

variable "account_id" {
  description = "AWS account ID"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "non-prod"
}

variable "bucket_name" {
  description = "S3 bucket name (optional, will generate if not provided)"
  type        = string
  default     = ""
}

variable "tags" {
  description = "Additional tags to apply to resources"
  type        = map(string)
  default     = {}
}
