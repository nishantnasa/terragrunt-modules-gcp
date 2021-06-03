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
  Authoritative Service Account IAM bindings
 *****************************************/
resource "google_service_account_iam_binding" "service_account_binding" {
  for_each           = module.helper.bindings
  service_account_id = "projects/${var.project_id}/serviceAccounts/${each.value.entity}"
  role               = each.value.role
  members            = each.value.members
}
