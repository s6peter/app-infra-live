# Golden pattern owned by the platform team. App teams include this file
# from every unit; it generates the AWS provider and the remote-state backend
# so units never repeat them.

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "aws" {
  region = "eu-west-1"
}
EOF
}

generate "backend" {
  path      = "backend.tf"
  if_exists = "overwrite_terragrunt"

  contents = <<EOF
terraform {
  backend "s3" {
    bucket       = "s6peter-tg-state-152617279670"
    key          = "${path_relative_to_include()}/terraform.tfstate"
    region       = "eu-west-1"
    encrypt      = true
    use_lockfile = true
  }
}
EOF
}
