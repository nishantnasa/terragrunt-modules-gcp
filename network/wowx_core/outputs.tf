output "network" {
  value       = module.vpc.network
  description = "The created network"
}

output "network_name" {
  value       = module.vpc.network_name
  description = "The ID of the VPC being created"
}

output "project_id" {
  value       = module.vpc.project_id
  description = "VPC project id"
}

output "network_self_link" {
  value       = module.vpc.network_self_link
  description = "The URI of the VPC being created"
}

output "subnets" {
  value       = module.subnets.subnets
  description = "A map with keys of form subnet_region/subnet_name and values being the outputs of the google_compute_subnetwork resources used to create corresponding subnets."
}

output "subnets_names" {
  value       = [for subnet in module.subnets.subnets : subnet.name]
  description = "The names of the subnets being created"
}

output "subnets_ips" {
  value       = [for subnet in module.subnets.subnets : subnet.ip_cidr_range]
  description = "The IPs and CIDRs of the subnets being created"
}

output "subnets_self_links" {
  value       = [for subnet in module.subnets.subnets : subnet.self_link]
  description = "The self-links of subnets being created"
}

output "subnets_regions" {
  value       = [for subnet in module.subnets.subnets : subnet.region]
  description = "The region where the subnets will be created"
}

output "subnets_secondary_ranges" {
  value       = [for subnet in module.subnets.subnets : subnet.secondary_ip_range]
  description = "The secondary ranges associated with these subnets"
}

output "route_names" {
  value       = [for route in module.routes.routes : route.name]
  description = "The route names associated with this VPC"
}

output "ingress_allow_rules" {
  description = "Ingress rules with allow blocks."
  value = module.firewall_rules.ingress_allow_rules
}

output "ingress_deny_rules" {
  description = "Ingress rules with deny blocks."
  value = module.firewall_rules.ingress_deny_rules
}

output "egress_allow_rules" {
  description = "Egress rules with allow blocks."
  value = module.firewall_rules.egress_allow_rules
}

output "egress_deny_rules" {
  description = "Egress rules with allow blocks."
  value = module.firewall_rules.egress_deny_rules
}
