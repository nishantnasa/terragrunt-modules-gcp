# Module Cloud Storage Guckets

This module is used to create cloud storage buckets in a project

## Example Usage
```
module "cloud_storage_buckets" {
  source = "../buckets"

  project_id = "my-project"

  storage_buckets = [
    {
      "name" = "${project_name}-${env}-bucket-1"
      "storage_class" = "MULTI_REGIONAL"
      "location" = "US"
      "bucket_policy_only" = true
    },
    {
      "name" = "${project_name}-${env}-bucket-2"
      "storage_class" = "STANDARD"
      "location" = "US"
      "bucket_policy_only" = false
    }
  ]
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| storage_buckets | List of GCS Bucket details. | map(list(string)) | n/a | yes |
| project\_id | Project in which the buckets are created. | string | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| buckets | Map of GCS Bucket details. |
| bucket_names | List of Cloud Storage Bucket names. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
