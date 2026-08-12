include "root" { path = find_in_parent_folders("root.hcl") }

terraform {
  source = "git::https://github.com/s6peter/platform-team.git//modules/sg?ref=v1.0.0"
}

locals {
  env = basename(dirname(get_terragrunt_dir()))   # → "staging"
}

inputs = {
  name                = "${local.env}-app-sg"
  vpc_id              = "vpc-0a1b2c3d4e5f6a7b8"
  ingress_port        = 80
  ingress_cidr_blocks = ["203.0.113.10/32"]       # office IP only
}
