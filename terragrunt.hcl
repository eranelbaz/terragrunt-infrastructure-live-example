locals {
      dir_struct = run_cmd("bash", "${get_terragrunt_dir()}/generate.sh")
}