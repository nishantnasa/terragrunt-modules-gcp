variable "network_name" {
  description = "Name of the network this set of firewall rules applies to."
}

variable "project_id" {
  description = "Project id of the project that holds the network."
}

/*
Terraform doesn't support default & optional values in object type ceclarations
https://github.com/hashicorp/terraform/issues/19898
*/
variable "firewall_rules" {
  description = "List of firewallS rule definitions."
  default     = []
  type = list(object({
    name                  = string
    description           = string
    direction             = string
    action                = string # (allow|deny)
    ip_ranges             = list(string)
    sources               = list(string)
    targets               = list(string)
    use_service_accounts  = bool
    rules = list(object({
      protocol = string
      ports    = list(string)
    }))
    extra_attributes      = map(string)
  }))
}


variable "module_depends_on" {
  description = "List of modules or resources this module depends on."
  type        = list
  default     = []
}
