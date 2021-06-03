terraform {
  # The configuration for this backend will be filled in by Terragrunt
  backend "gcs" {}

  # Live modules pin exact Terraform version; generic modules let consumers pin the version.
  # The latest version of Terragrunt (v0.19.0 and above) requires Terraform 0.12.0 or above.
  required_version = "> 0.12.6"
}

/******************************************
  Run helper module to get generic calculated data
 *****************************************/
module "helper" {
  source   = "../helper"
  bindings = var.bindings
}

/******************************************
  Additive Artifact Registry Repository IAM bindings
 *****************************************/
resource "google_artifact_registry_repository_iam_member" "this" {
  for_each    = module.helper.bindings_additive
  provider    = google-beta

  location    = split("__", each.value.entity)[0]
  repository  = "projects/gcp-wow-rwds-ai-mleops-prod/locations/${split("__", each.value.entity)[0]}/repositories/${split("__", each.value.entity)[1]}"
  role        = each.value.role
  member      = each.value.member
}

