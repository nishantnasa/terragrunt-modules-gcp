terraform {
  # The configuration for this backend will be filled in by Terragrunt
  backend "gcs" {}

  # Live modules pin exact Terraform version; generic modules let consumers pin the version.
  # The latest version of Terragrunt (v0.19.0 and above) requires Terraform 0.12.0 or above.
  required_version = "> 0.12.6"
}

locals {
  buckets = {
    for bucket in var.storage_buckets :
    lower(bucket.name) => bucket
  }
}

/******************************************
  Create User-Managed Google Cloud Storage Buckets
 *****************************************/
resource "google_storage_bucket" "bucket" {
  for_each            = local.buckets
  name                = lower(each.value.name)
  project             = var.project_id
  location            = upper(each.value.location)
  storage_class       = upper(each.value.storage_class)
  force_destroy       = each.value.force_destroy
  uniform_bucket_level_access  = each.value.uniform_bucket_level_access

  labels = merge(
    each.value.labels,
    {
      name = replace(each.value.name,  ".", "-")
    }
  )

  versioning {
    enabled = each.value.versioning
  }

  # Having a permanent encryption block with default_kms_key_name = "" works
  # but results in terraform applying a change every run
  # There is no enabled = false attribute available to ignore the block
  dynamic "encryption" {
    # If an encryption key name is set -> Create a single encryption block
    for_each = trimspace(lower(each.value.encryption_key_name)) != "" ? [true] : []
    content {
      default_kms_key_name = trimspace(lower(each.value.encryption_key_name))
    }
  }

  dynamic "cors" {
    for_each = each.value.cors
    content {
      origin          = lookup(cors.value, "origin", null)
      method          = lookup(cors.value, "method", null)
      response_header = lookup(cors.value, "response_header", null)
      max_age_seconds = lookup(cors.value, "max_age_seconds", null)
    }
  }

  dynamic "website" {
    for_each = each.value.website
    content {
      main_page_suffix = lookup(website.value, "main_page_suffix", null)
      not_found_page   = lookup(website.value, "not_found_page", null)
    }
  }

  dynamic "lifecycle_rule" {
    for_each = each.value.lifecycle_rules
    content {
      action {
        type          = lifecycle_rule.value.action.type
        storage_class = lookup(lifecycle_rule.value.action, "storage_class", null)
      }
      condition {
        age                   = lookup(lifecycle_rule.value.condition, "age", null)
        created_before        = lookup(lifecycle_rule.value.condition, "created_before", null)
        with_state            = lookup(lifecycle_rule.value.condition, "with_state", null)
        matches_storage_class = contains(keys(lifecycle_rule.value.condition), "matches_storage_class") ? split(",", lifecycle_rule.value.condition["matches_storage_class"]) : null
        num_newer_versions    = lookup(lifecycle_rule.value.condition, "num_newer_versions", null)
      }
    }
  }
}
