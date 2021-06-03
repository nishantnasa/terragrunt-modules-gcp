terraform {
  # The configuration for this backend will be filled in by Terragrunt
  backend "gcs" {}

  # Live modules pin exact Terraform version; generic modules let consumers pin the version.
  # The latest version of Terragrunt (v0.19.0 and above) requires Terraform 0.12.0 or above.
  required_version = "> 0.12.6"
}

locals {
  firewall_rules = {
    for i, firewall_rule in var.firewall_rules :
    lookup(firewall_rule, "name", format("%s-%s-%d", lower(var.network_name), "firewall_rule", i)) => firewall_rule
  }
}

/******************************************
  Firewall Rules
 *****************************************/
resource "google_compute_firewall" "firewall_rule" {
  for_each                = local.firewall_rules

  project                 = var.project_id
  network                 = var.network_name

  name                    = each.key
  description             = each.value.description
  direction               = upper(each.value.direction)
  disabled                = lookup(each.value.extra_attributes, "disabled", false)
  priority                = lookup(each.value.extra_attributes, "priority", 1000)

  source_ranges           = upper(each.value.direction) == "INGRESS" ? each.value.ip_ranges : null
  destination_ranges      = upper(each.value.direction) == "EGRESS" ? each.value.ip_ranges : null
  source_tags             = each.value.use_service_accounts || upper(each.value.direction) == "EGRESS" ? null : each.value.sources
  source_service_accounts = each.value.use_service_accounts && upper(each.value.direction) == "INGRESS" ? each.value.sources : null
  target_tags             = each.value.use_service_accounts ? null : each.value.targets
  target_service_accounts = each.value.use_service_accounts ? each.value.targets : null

  dynamic "allow" {
    for_each = [for rule in each.value.rules : rule if each.value.action == "allow"]
    iterator = rule
    content {
      protocol = rule.value.protocol
      ports    = rule.value.ports
    }
  }

  dynamic "deny" {
    for_each = [for rule in each.value.rules : rule if each.value.action == "deny"]
    iterator = rule
    content {
      protocol = rule.value.protocol
      ports    = rule.value.ports
    }
  }

  depends_on = [var.module_depends_on]
}
