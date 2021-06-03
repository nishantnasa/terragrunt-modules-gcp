variable "project_id" {
  description = "Project in which the service accounts are created."
  type        = string
}

variable registry_repositories {
  description = "List of artifact registry repositories to be created."
  type        = list(map(string))
}
