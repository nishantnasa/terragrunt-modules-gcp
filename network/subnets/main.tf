terraform {
  # The configuration for this backend will be filled in by Terragrunt
  backend "gcs" {}

  # Live modules pin exact Terraform version; generic modules let consumers pin the version.
  # The latest version of Terragrunt (v0.19.0 and above) requires Terraform 0.12.0 or above.
  required_version = "> 0.12.6"
}

locals {
  subnets = {
    for subnet in var.subnets :
    "${subnet.region}/${subnet.name}" => subnet
  }
}


/******************************************
	Subnets configuration
 *****************************************/
resource "google_compute_subnetwork" "subnetwork" {
  for_each                 = local.subnets
  name                     = each.value.name
  ip_cidr_range            = each.value.ip
  region                   = each.value.region
  private_ip_google_access = lookup(each.value, "private_access", "false")
  dynamic "log_config" {
    for_each = lookup(each.value, "flow_logs", false) ? [{
      aggregation_interval = lookup(each.value, "flow_logs_interval", "INTERVAL_5_SEC")
      flow_sampling        = lookup(each.value, "flow_logs_sampling", "0.5")
      metadata             = lookup(each.value, "flow_logs_metadata", "INCLUDE_ALL_METADATA")
    }] : []
    content {
      aggregation_interval = log_config.value.aggregation_interval
      flow_sampling        = log_config.value.flow_sampling
      metadata             = log_config.value.metadata
    }
  }
  network     = var.network_name
  project     = var.project_id
  description = lookup(each.value, "description", null)
  secondary_ip_range = [
    for i in range(
      length(
        contains(
        keys(var.secondary_ranges), each.value.name) == true
        ? var.secondary_ranges[each.value.name]
        : []
    )) :
    var.secondary_ranges[each.value.name][i]
  ]
}
