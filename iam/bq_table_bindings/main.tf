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
  Authoritative BigQuery Table IAM bindings
 *****************************************/
resource "google_bigquery_table_iam_binding" "bigquery_table_binding" {
  for_each           = module.helper.bindings
  dataset_id         = split("__", each.value.entity)[0]
  table_id           = split("__", each.value.entity)[1]
  role               = each.value.role
  members            = each.value.members
  project            = var.project_id
}


/******************************************
  Additive BigQuery Table IAM bindings
 *****************************************/
resource "google_bigquery_table_iam_member" "bigquery_table_binding_additive" {
  for_each           = module.helper.bindings_additive
  dataset_id         = split("__", each.value.entity)[0]
  table_id           = split("__", each.value.entity)[1]
  role               = each.value.role
  member             = each.value.member
  project            = var.project_id
}
