variable "project_id" {
  description = "Project id of the project that holds the network."
  type        = string
}

variable "compute_engine_api_enabled" {
  description = "Compute engine API flag"
  type        = bool
  default     = true
}

variable "storage_transfer_api_enabled" {
  description = "Storage Transfer API flag"
  type        = bool
}

