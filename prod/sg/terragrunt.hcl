include "root" { path = find_in_parent_folders("root.hcl") }

terraform {
  source = "git::https://github.com/s6peter/platform-team.git//modules/sg?ref=v1.1.0"
}

locals {
  env = basename(dirname(get_terragrunt_dir()))   # → "prod"
}

inputs = {
  name                = "${local.env}-app-sg"
  vpc_id              = "vpc-0a1b2c3d4e5f6a7b8"
  ingress_port        = 80
  ingress_cidr_blocks = ["0.0.0.0/0"]             # open to the world
}
