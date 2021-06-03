terraform {
  # The configuration for this backend will be filled in by Terragrunt
  backend "gcs" {}

  # Live modules pin exact Terraform version; generic modules let consumers pin the version.
  # The latest version of Terragrunt (v0.19.0 and above) requires Terraform 0.12.0 or above.
  required_version = "> 0.12.6"
}

locals {
  registry_repositories = {
    for repo in var.registry_repositories :
    repo.name => repo
  }
}

/******************************************
  Create Artifact Regsitry Repositories
 *****************************************/
resource "google_artifact_registry_repository" "this" {
  for_each      = local.registry_repositories
  provider      = google-beta
  project       = var.project_id

  location      = lower(each.value.location)
  repository_id = each.value.name
  description   = join(" ", ["Artifact Registry", lower(each.value.format), "repository for", each.key])
  format        = upper(each.value.format)
  kms_key_name  = lookup(each.value, "encryption_key", "")
}
