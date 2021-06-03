variable "bindings" {
  description = "list of service-account and role mappings with their list of members to add the IAM policies/bindings"
  type        = list(object({
    entity    = string
    role      = string
    members   = list(any)
    mode      = string
  }))
}

