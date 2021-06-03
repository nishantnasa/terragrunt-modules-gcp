variable "project_id" {
  description = "Project in which the service accounts are created."
  type        = string
}

variable "service_accounts" {
  description = "List of user-managed service accounts to be created."
  type        = list(map(string))
}
