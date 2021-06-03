terraform {
  # The configuration for this backend will be filled in by Terragrunt
  backend "gcs" {}

  # Live modules pin exact Terraform version; generic modules let consumers pin the version.
  # The latest version of Terragrunt (v0.19.0 and above) requires Terraform 0.12.0 or above.
  required_version = "> 0.12.6"
}

locals {
  # intermediate locals
  nat_ips_length                 = length(var.nat_ips)
  default_nat_ip_allocate_option = local.nat_ips_length > 0 ? "MANUAL_ONLY" : "AUTO_ONLY"
  # locals for google_compute_router_nat
  nat_ip_allocate_option = var.nat_ip_allocate_option ? var.nat_ip_allocate_option : local.default_nat_ip_allocate_option
  name                   = var.name
  router                 = var.create_router ? google_compute_router.router[0].name : var.router
}

resource "google_compute_router" "router" {
  count   = var.create_router ? 1 : 0
  name    = var.router
  project = var.project_id
  region  = var.region
  network = var.network
  bgp {
    asn = var.router_asn
  }
}

resource "google_compute_router_nat" "main" {
  project                            = var.project_id
  region                             = var.region
  name                               = local.name
  router                             = local.router
  nat_ip_allocate_option             = local.nat_ip_allocate_option
  nat_ips                            = var.nat_ips
  source_subnetwork_ip_ranges_to_nat = var.source_subnetwork_ip_ranges_to_nat
  min_ports_per_vm                   = var.min_ports_per_vm
  udp_idle_timeout_sec               = var.udp_idle_timeout_sec
  icmp_idle_timeout_sec              = var.icmp_idle_timeout_sec
  tcp_established_idle_timeout_sec   = var.tcp_established_idle_timeout_sec
  tcp_transitory_idle_timeout_sec    = var.tcp_transitory_idle_timeout_sec

  dynamic "subnetwork" {
    for_each = var.subnetworks
    content {
      name                     = subnetwork.value.name
      source_ip_ranges_to_nat  = subnetwork.value.source_ip_ranges_to_nat
      secondary_ip_range_names = contains(subnetwork.value.source_ip_ranges_to_nat, "LIST_OF_SECONDARY_IP_RANGES") ? subnetwork.value.secondary_ip_range_names : []
    }
  }

  dynamic "log_config" {
    for_each = var.log_config_enable == true ? [{
      enable = var.log_config_enable
      filter = var.log_config_filter
    }] : []

    content {
      enable = log_config.value.enable
      filter = log_config.value.filter
    }
  }
}

