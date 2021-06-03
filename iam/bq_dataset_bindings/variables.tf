variable "project_id" {
  description = "Project in which the service account bindings are created."
  type        = string
}

variable "bindings" {
  description = "list of service-account and role mappings with their list of members to add the IAM policies/bindings"
  type        = list(object({
    entity    = string
    role      = string
    members   = list(list(string))
    mode      = string
  }))
}
