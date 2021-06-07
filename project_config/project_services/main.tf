terraform {
  # The configuration for this backend will be filled in by Terragrunt
  backend "gcs" {}

  # Live modules pin exact Terraform version; generic modules let consumers pin the version.
  # The latest version of Terragrunt (v0.19.0 and above) requires Terraform 0.12.0 or above.
  required_version = "> 0.12.6"
}

locals {
  project_apis = var.enable_apis ? flatten(jsondecode(var.activate_apis)) : []
  api_set = toset([ 
    for api in local.project_apis:
    api
    # prevent accidental update of service usage api
    if lower(api) != "serviceusage.googleapis.com" 
  ])
}

resource "google_project_service" "cloud_resource_manager" {
  project                    = var.project_id
  service                    = "cloudresourcemanager.googleapis.com"
  disable_on_destroy         = false
  disable_dependent_services = false
}

resource "google_project_service" "iam" {
  project                    = var.project_id
  service                    = "iam.googleapis.com"
  disable_on_destroy         = false
  disable_dependent_services = false

  depends_on = [
    google_project_service.cloud_resource_manager
  ]
}

resource "google_project_service" "compute_engine" {
  project                    = var.project_id
  service                    = "compute.googleapis.com"
  disable_on_destroy         = false
  disable_dependent_services = false

  depends_on = [
    google_project_service.iam
  ]
}

resource "google_project_service" "kubernetes_engine" {
  project                    = var.project_id
  service                    = "container.googleapis.com"
  disable_on_destroy         = false
  disable_dependent_services = false

  depends_on = [
    google_project_service.compute_engine
  ]
}

resource "google_project_service" "project_services" {
  for_each                   = local.api_set
  project                    = var.project_id
  service                    = each.value
  disable_on_destroy         = var.disable_services_on_destroy
  disable_dependent_services = var.disable_dependent_services

  depends_on = [
    google_project_service.kubernetes_engine
  ]
}
