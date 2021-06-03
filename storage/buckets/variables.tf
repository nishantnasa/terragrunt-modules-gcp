variable "project_id" {
  description = "Bucket project id."
  type        = string
}

variable "storage_buckets" {
  description = "list of bucket details"
  type        = list(object({
    name                        = string
    storage_class               = string
    location                    = string
    force_destroy               = bool
    uniform_bucket_level_access = bool
    labels                      = map(string)
    versioning                  = bool
    encryption_key_name         = string
    cors                        = any
    website                     = any
    lifecycle_rules             = set(object({
      action                    = map(string)
      condition                 = map(string)
    }))
  }))
}
