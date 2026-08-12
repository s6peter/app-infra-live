# app-infra-live

App team's Terragrunt live configs. Units consume the platform team's
versioned modules from [s6peter/platform-team](https://github.com/s6peter/platform-team)
via git sources pinned to release tags.

```hcl
terraform {
  source = "git::https://github.com/s6peter/platform-team.git//modules/ec2?ref=v1.0.0"
}
```

Each environment (`dev`, `staging`, `prod`) has three units — `sg`, `iam`,
`ec2` — and `ec2` wires the others through `dependency` blocks. State is
remote: one key per unit in the shared S3 bucket (`path_relative_to_include()`
in `root.hcl`).

```bash
terragrunt render                  # inspect one unit's merged config
terragrunt run --all -- plan       # dry-run all 9 units
```
