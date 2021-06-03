terraform {
  # The configuration for this backend will be filled in by Terragrunt
  backend "gcs" {}

  # Live modules pin exact Terraform version; generic modules let consumers pin the version.
  # The latest version of Terragrunt (v0.19.0 and above) requires Terraform 0.12.0 or above.
  required_version = "> 0.12.6"
}

/******************************************
  WowX Core VPC configuration
 *****************************************/
module "vpc" {
  source                                 = "../vpc"
  network_name                           = var.network_name
  project_id                             = var.project_id
  description                            = join(" ", ["Core VPC for", var.project_display_name, "project"])
}

/******************************************
  WowX Core Subnets configuration
 *****************************************/
module "subnets" {
  source           = "../subnets"
  project_id       = var.project_id
  network_name     = module.vpc.network_name
  subnets          = var.subnets
  secondary_ranges = var.secondary_ranges
}

/******************************************
  WowX Core Routes
 *****************************************/
module "routes" {
  source            = "../routes"
  project_id        = var.project_id
  network_name      = module.vpc.network_name
  routes            = var.routes
  module_depends_on = [module.subnets.subnets]
}

/******************************************
  WowX Core Firewall Rules
 *****************************************/
module "firewall_rules" {
  source          = "../firewall_rules"
  project_id      = var.project_id
  network_name    = module.vpc.network_name
  firewall_rules  = var.firewall_rules
  module_depends_on = [module.subnets.subnets]
}
