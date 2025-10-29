# This file can be used for root-level terragrunt configuration
# The generate.sh script should be run manually or via CI/CD, not automatically
 locals {
   dir_struct = run_cmd("bash", "${get_terragrunt_dir()}/generate.sh")
 }