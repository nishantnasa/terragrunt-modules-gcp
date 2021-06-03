/******************************************
  WooliesX Custom Variables
 *****************************************/
variable "project_display_name" {
  type        = string
}

/******************************************
  Generic Module Variables
 *****************************************/
variable "project_id" {
  description = "The ID of the project where this VPC will be created"
}

variable "network_name" {
  description = "The name of the network being created"
}

variable "subnets" {
  type        = list(map(string))
  description = "The list of subnets being created"
}

variable "secondary_ranges" {
  type        = map(list(object({ range_name = string, ip_cidr_range = string })))
  description = "Secondary ranges that will be used in some of the subnets"
  default     = {}
}

variable "routes" {
  type        = list(map(string))
  description = "List of routes being created in this VPC"
}

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
