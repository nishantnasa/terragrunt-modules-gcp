terraform {
  # The configuration for this backend will be filled in by Terragrunt
  backend "gcs" {}

  # Live modules pin exact Terraform version; generic modules let consumers pin the version.
  # The latest version of Terragrunt (v0.19.0 and above) requires Terraform 0.12.0 or above.
  required_version = "> 0.12.6"
}

locals {
  custom_roles_org = {
    for role in var.custom_roles:
    role.role_id => {
      org_id = role.target_id,
      role_id = role.role_id,
      title = role.title == "" ? role.role_id : role.title,
      description = role.description == "" ? join(" ", ["Custom IAM role for", role.role_id]) : role.description,
      permissions = distinct(flatten(role.permissions)),
      stage       = role.stage == "" ? "GA" : role.stage,
    }
    if role.target_level == "org"
  }

  custom_roles_project = {
    for role in var.custom_roles:
    role.role_id => {
      project_id = role.target_id,
      role_id = role.role_id,
      title = role.title == "" ? role.role_id : role.title,
      description = role.description == "" ? join(" ", ["Custom IAM role for", role.role_id]) : role.description,
      permissions = distinct(flatten(role.permissions)),
      stage       = role.stage == "" ? "GA" : role.stage,
    }
    if role.target_level == "project"
  }

  default_custom_roles_project = {
    for role in local.project_defaults:
    role.role_id => {
      project_id = var.project_id,
      role_id = role.role_id,
      title = role.title == "" ? role.role_id : role.title,
      description = join(" ", ["Custom IAM Default Project role for", role.role_id]),
      permissions = role.permissions,
      stage       = role.stage == "" ? "GA" : role.stage,
    }
  }
}

/******************************************
  Custom IAM Org Roles
 *****************************************/
resource "google_organization_iam_custom_role" "custom_role" {
  for_each    = local.custom_roles_org

  org_id      = each.value.org_id
  role_id     = each.value.role_id
  title       = each.value.title
  description = each.value.description
  permissions = each.value.permissions
  stage       = each.value.stage
}

/******************************************
  Custom IAM Project Roles
 *****************************************/
resource "google_project_iam_custom_role" "custom_role" {
  for_each    = merge(local.custom_roles_project, local.default_custom_roles_project)

  project     = each.value.project_id
  role_id     = each.value.role_id
  title       = each.value.title
  description = each.value.description
  permissions = each.value.permissions
  stage       = each.value.stage
}
