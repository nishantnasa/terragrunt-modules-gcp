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
  Authoritative Storage Bucket IAM bindings
 *****************************************/
resource "google_storage_bucket_iam_binding" "storage_bucket_binding" {
  for_each           = module.helper.bindings
  bucket             = each.value.entity
  role               = each.value.role
  members            = each.value.members
}


/******************************************
  Additive Storage Bucket IAM bindings
 *****************************************/
resource "google_storage_bucket_iam_member" "storage_bucket_binding_additive" {
  for_each           = module.helper.bindings_additive
  bucket             = each.value.entity
  role               = each.value.role
  member             = each.value.member
}
