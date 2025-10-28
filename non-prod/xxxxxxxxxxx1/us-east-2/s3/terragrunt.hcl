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
