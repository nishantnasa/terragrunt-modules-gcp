# Module service_account IAM

This module is used to assign IAM bindings for service accounts to specific roles

## Example Usage
```
module "service_account_iam_bindings" {
  source = "../service_account_bindings"

  bindings = [
    {
      "entity" = "my-service-account-one@sample-project.iam.gserviceaccount.com"
      "role" = "roles/iam.serviceAccountKeyAdmin"
      "members" = [
        "serviceAccount:my-sa@my-project.iam.gserviceaccount.com",
        "group:my-group@my-org.com",
        "user:my-user@my-org.com",
      ],
      "mode" = "authoritative"
    },
    {
      "entity" = "my-service-account-two@sample-project.iam.gserviceaccount.com"
      "role" = "roles/iam.serviceAccountTokenCreator"
      "members" = [
        "serviceAccount:my-sa@my-project.iam.gserviceaccount.com",
        "group:my-group@my-org.com",
        "user:my-user@my-org.com",
      ],
      "mode" = "authoritative"
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
