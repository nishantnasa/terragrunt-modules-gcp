# Module IAM Custom Roles

This module is used to create custom roles at organization or project level.

## Usage - Custom Role at Organization Level

```hcl
module "custom-roles" {
  source = "../custom_roles"

  custom_roles = [
    {
      target_level = "org",
      target_id    = "123456789"
      id           = "custom_role_id"
      title        = "Custom Role Unique Title"
      description  = "Custom Role Description"
      permissions  = ["iam.roles.list", "iam.roles.create", "iam.roles.delete"]
      stage        = "BETA"
    },
  ]
}
```

## Usage - Custom Role at Project Level

```hcl
module "custom-roles" {
  source = "../custom_roles"

  custom_roles = [
    {
      target_level = "project"
      target_id    = "project_id_123"
      id           = "custom_role_id"
      title        = "Custom Role Unique Title"
      description  = "Custom Role Description"
      permissions  = ["iam.roles.list", "iam.roles.create", "iam.roles.delete"]
      stage        = "GA"
    },
  ]
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

## Outputs

| Name | Description |
|------|-------------|
| custom\_roles\_org | Oorganisation level custom roles managed by the module. |
| custom\_roles\_project | Project level custom roles managed by the module. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
