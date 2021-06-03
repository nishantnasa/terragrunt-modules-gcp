# Module service_account IAM

This module is used to create user-managed service accounts in a project

## Example Usage
```
module "service_accounts" {
  source = "../service_accounts"

  project_id = "my-project"

  service_accounts = [
    {
      "key"  = "main"
      "name" = "my-project-dev"
    },
    {
      "key"  = "second"
      "name" = "my-project-dev"
    }
  ]
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| service\_accounts | LList of user-managed service accounts to be created | map(list(string)) | n/a | yes |
| project\_id | PProject in which the service accounts are created. | string | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| service\_accounts | Map of User Managed Service Accounts. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
