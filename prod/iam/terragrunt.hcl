include "root" { path = find_in_parent_folders("root.hcl") }

terraform {
  source = "git::https://github.com/s6peter/platform-team.git//modules/iam?ref=v1.0.0"
}

locals {
  env = basename(dirname(get_terragrunt_dir()))
}

inputs = {
  name = "${local.env}-app-role"
}
