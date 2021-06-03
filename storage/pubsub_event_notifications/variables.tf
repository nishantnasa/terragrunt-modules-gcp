variable project_id {
  description = "Bucket project id."
  type        = string
}
variable storage_notifications {
  description = "list of storage buckets to enable pubsub notifications"
  type        = list(object({
    id          = string
    bucket      = string
    topic       = string
    event_types = list(string)
    attributes  = map(string)
  }))
}
