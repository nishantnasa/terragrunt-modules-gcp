# Enable PubSub Notifcations for Cloud Storage Buckets

This module is used to create pubsub topic and enable trigger notifications for cloud storage bucket events. 

## Example Usage
```hcl
module storage_notifications {
  source = "../pubsub_event_notifications"

  project_id = "my-project"

  storage_notifications = [
    {
      "id" = "bucket-1"
      "name" = "bucket-1"
      "event_types" = []
      "attributes" = {
        name = "bucket-1-event-notifications"
      }
    },
    {
      "id" = "bucket-2"
      "name" = "bucket-2"
      "event_types" = ["OBJECT_FINALIZE"]
      "attributes" = {}
    },
  ]
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| storage_notifications | List of pubsub storage notifications. | list(object({})) | n/a | yes |
| project\_id | Project in which the buckets are created. | string | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
|  |  |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
