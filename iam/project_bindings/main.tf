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
  Authoritative Project IAM bindings
 *****************************************/
resource "google_project_iam_binding" "project_binding" {
  for_each           = module.helper.bindings
  project            = each.value.entity
  role               = each.value.role
  members            = each.value.members
}


/******************************************
  Additive Project IAM bindings
 *****************************************/
resource "google_project_iam_member" "project_binding_additive" {
  for_each           = module.helper.bindings_additive
  project            = each.value.entity
  role               = each.value.role
  member             = each.value.member
}
