terraform {
  # The configuration for this backend will be filled in by Terragrunt
  backend "gcs" {}

  # Live modules pin exact Terraform version; generic modules let consumers pin the version.
  # The latest version of Terragrunt (v0.19.0 and above) requires Terraform 0.12.0 or above.
  required_version = "> 0.12.6"
}

locals {
  pubsub_event_notifications = {
    for notification in var.storage_notifications :
    lower(notification.id) => notification
  }

  default_event_types = [
    "OBJECT_FINALIZE", 
    "OBJECT_METADATA_UPDATE",
    "OBJECT_DELETE",
    "OBJECT_ARCHIVE"
  ]
}

// Enable notifications by giving the correct IAM permission to the unique service account.

data google_storage_project_service_account gcs_account {
  project = var.project_id
}

# Authoritative binding to ensure no extra memebers 
# added manually by mistake for this topic
resource google_pubsub_topic_iam_member this {
  for_each  = local.pubsub_event_notifications
  project   = var.project_id
  topic     = each.value.topic
  role      = "roles/pubsub.publisher"
  member   = "serviceAccount:${data.google_storage_project_service_account.gcs_account.email_address}"
}

// End Enabling Notifications

resource google_storage_notification this {
  for_each          = local.pubsub_event_notifications
  bucket            = each.value.bucket
  payload_format    = "JSON_API_V1"
  topic             = each.value.topic
  event_types       = each.value.event_types == [] ? local.default_event_types : [
    for event_type in each.value.event_types:
    upper(event_type)
  ]
  custom_attributes = merge(
    {
      topic   = split("/", each.value.topic)[3]
    },
    each.value.attributes
  )
}
