# Module service_account IAM

This module is used to assign IAM bindings for storage bucket to specific roles

## Example Usage
```
module "storage_bucket_iam_bindings" {
  source = "../storage_bucket_bindings"

  bindings = [
    {
      "entity" = "storage-bucket-1-name"
      "role" = "roles/storage.admin"
      "members" = [
        "group:storage-administrators-group@my-org.com",
        "user:bucket-administrator@my-org.com",
      ],
      "mode" = "authoritative"
    },
    {
      "entity" = "storage-bucket-2-name"
      "role" = "roles/storage.admin"
      "members" = [
        "group:storage-administrators-group@my-org.com",
        "user:bucket-administrator@my-org.com",
      ],
      "mode" = "additive"
    }
  ]
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| bindings | List of objects | string) | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| bound\_entities | Entities which received bindings. |
| bound\_roles | Roles which were assigned to members using this module. |
| bound\_members | Members which were bound to roles using this module. |
| bindings\_by\_role | Entity bindings by role. |
| bindings\_by\_member | Entity bindings by member. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
