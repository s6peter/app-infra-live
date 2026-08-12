include "root" { path = find_in_parent_folders("root.hcl") }

terraform {
  source = "git::https://github.com/s6peter/platform-team.git//modules/ec2?ref=v1.2.0"
}

locals {
  env = basename(dirname(get_terragrunt_dir()))
}

# ordering only — sg and iam must exist before ec2
dependencies {
  paths = ["../sg", "../iam"]
}

# read their outputs from state — no hard-coded IDs
dependency "sg" {
  config_path = "../sg"
  mock_outputs = { sg_id = "sg-00000000000000000" }
}

dependency "iam" {
  config_path = "../iam"
  mock_outputs = { instance_profile_name = "mock-profile" }
}

inputs = {
  name                 = "${local.env}-app"
  environment          = local.env
  instance_type        = "t3.micro"
  subnet_id            = "subnet-0a1b2c3d4e5f6a7b8"
  security_group_ids   = [dependency.sg.outputs.sg_id]
  iam_instance_profile = dependency.iam.outputs.instance_profile_name
  monitoring           = true
}
