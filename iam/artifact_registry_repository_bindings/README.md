# Module Artifact Regsitry Repository IAM

This module is used to assign IAM bindings for artifact registry repositories to specific roles

## Example Usage
```
module "artifact_registry_repository_bindings" {
  source = "../artifact_registry_repository_bindings"

  bindings = [
    {
      "entity": "docker__us__repo1-prod",
      "role": "roles/artifactregistry.repoAdmin",
      "members" = [
        "serviceAccount:my-sa@my-project.iam.gserviceaccount.com",
        "group:my-group@my-org.com",
        "user:my-user@my-org.com",
      ],
      "mode": "additive"
    },
    {
      "entity": "docker__us-central1__repo2-dev",
      "role": "roles/artifactregistry.repoAdmin",
      "members" = [
        "serviceAccount:my-sa@my-project.iam.gserviceaccount.com",
        "group:my-group@my-org.com",
        "user:my-user@my-org.com",
      ],
      "mode": "additive"
    },
    ...
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
