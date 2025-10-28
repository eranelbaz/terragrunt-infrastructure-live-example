#!/bin/bash
set -e

# Configuration Variables
# Target account IDs
targetaccounts=("xxxxxxxxxxx1" "xxxxxxxxxxx2") # Matching account names
accountnames=("xx-xxxx-x-xxx" "xxxx-xxx-x-xx")

# Target regions
regions=("us-east-1" "us-east-2")

# Environment directory
env_dir="non-prod"

# Module name
module_name="s3"

# Create environment directory and env.hcl
mkdir -p "$env_dir"
cat > "$env_dir/env.hcl" <<EOF
locals {
 environment = "${env_dir}"
}
EOF

# Create account and region directories with Terragrunt configs
for i in "${!targetaccounts[@]}"; do
   account="${targetaccounts[$i]}"
   accountname="${accountnames[$i]}"
   
   mkdir -p "$env_dir/$account"
   
   # account.hcl
   cat > "$env_dir/$account/account.hcl" <<EOF
locals {
 account_name  = "$accountname"
 aws_account_id = "$account"
}
EOF
   
   for region in "${regions[@]}"; do
       mkdir -p "$env_dir/$account/$region/$module_name"
       
       # region.hcl
       cat > "$env_dir/$account/$region/region.hcl" <<EOF
locals {
 aws_region = "$region"
}
EOF
       
       # terragrunt.hcl inside module directory
       cat > "$env_dir/$account/$region/$module_name/terragrunt.hcl" <<'EOF'
include "root" {
  path = find_in_parent_folders("root.hcl")
}

include "nonprod" {
  path = "${dirname(find_in_parent_folders("root.hcl"))}/common/target.hcl"
  expose = true
}

include "common" {
  path = "${dirname(find_in_parent_folders("root.hcl"))}/common/common.hcl"
  expose = true
}

include "region" {
  path  = find_in_parent_folders("region.hcl")
  expose = true
}

include "account" {
  path  = find_in_parent_folders("account.hcl")
  expose = true
}

include "env" {
  path  = find_in_parent_folders("env.hcl")
  expose = true
}

terraform {
  source = "${include.common.locals.base_source_url}"
}

inputs = {
  region   = "${include.region.locals.aws_region}"
  account_id = "${include.account.locals.aws_account_id}"
}
EOF
   done
done

echo "Folder structure and Terragrunt configs generated successfully."