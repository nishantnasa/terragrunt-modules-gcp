terraform {
  # The configuration for this backend will be filled in by Terragrunt
  backend "gcs" {}

  # Live modules pin exact Terraform version; generic modules let consumers pin the version.
  # The latest version of Terragrunt (v0.19.0 and above) requires Terraform 0.12.0 or above.
  required_version = "> 0.12.6"
}

locals {
  compute_engine_enabled_map = {
    for bool_val in [var.compute_engine_api_enabled]:
    "compute_engine" => bool_val
    if bool_val == true
  }

  storage_transfer_enabled_map = {
    for bool_val in [var.storage_transfer_api_enabled]:
    "storage_transfer" => bool_val
    if bool_val == true
  }
}

data "google_project" "project" {
  project_id = var.project_id
}

data "google_compute_default_service_account" "default" {
  for_each = local.compute_engine_enabled_map
  project = var.project_id
}

data "google_storage_transfer_project_service_account" "default" {
  for_each = local.storage_transfer_enabled_map
  project = var.project_id
}
