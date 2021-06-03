variable project_id {
  type = string
}

variable region {
  type = string
  default = "us-central1"
}

variable release_bucket_location {
  type = string
  default = "de-prd-releases"
}

variable dataproc_init_bucket_location {
  type = string
  default = "dataproc-initialization-actions"
}

variable subnetwork_uri {
  type = string
  default = ""
}

variable zone_uri {
  type = string
  default = "us-central1-b"
}

variable service_account {
  type = string
  default = ""
}

variable product_name {
  type = string
}

variable env {
  type = string
}

variable trigger_id {
  type = string
  default = "1"
}

variable shell_environment {
  type = map(string)
  default = {}
}
