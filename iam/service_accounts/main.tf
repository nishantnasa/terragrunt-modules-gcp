terraform {
  # The configuration for this backend will be filled in by Terragrunt
  backend "gcs" {}

  # Live modules pin exact Terraform version; generic modules let consumers pin the version.
  # The latest version of Terragrunt (v0.19.0 and above) requires Terraform 0.12.0 or above.
  required_version = "> 0.12.6"
}

locals {
  service_accounts = {
    for sa in var.service_accounts :
    sa.key => sa.name
  }
}

/******************************************
  Create User-Managed Service Accounts
 *****************************************/
resource "google_service_account" "service_account" {
  for_each     = local.service_accounts
  account_id   = each.value
  display_name = join(" ", ["service account", each.value])
  description  = join(" ", [each.key, "service account", each.value, "for project", var.project_id])
  project      = var.project_id
}


/******************************************
  Creation of service account is eventually consistent
  Add a delay of 30 seconds after creation
 *****************************************/
resource "null_resource" "delay" {
  for_each     = local.service_accounts
  provisioner "local-exec" {
    command    = "sleep 10"
  }
  triggers = {
    "before"   = google_service_account.service_account[each.key].id
  }
}
