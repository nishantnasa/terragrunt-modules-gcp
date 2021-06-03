# Google Artifact Registry Repository

This module is used to create artifact registry repositories in a GCP project

## Example Usage
```
module "artifact_registry_repositories" {
  source = "./artifact_registry_repositories"

  project_id = "my-project"

  registry_repositories = [
    {
      "id"  = "repo1"
      "location" = "us"
      "format" = "docker"
      "encryption_key" = ""
    },
    {
      "id"  = "repo2"
      "location" = "us-central1"
      "format" = "docker"
      "encryption_key" = "projects/my-project/locations/us-central1/keyRings/my-keyring/cryptoKeys/my-key"
    },
    ...
  ]
}
```


<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| registry\_repositories | List of registry repositories to be created | list(map(string)) | n/a | yes |
| project\_id | Project in which the registry repositories are created. | string | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| registry\_repositories | Map of created Artifact Registry repositories. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
