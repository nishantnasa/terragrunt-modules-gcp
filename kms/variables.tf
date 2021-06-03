# Required variables

variable "project_id" {
  description = "GCP project id"
  type        = string
}

variable "location" {
  description = "Location for the keyring"
  type        = string
}

variable "keyring" {
  description = "Keyring name"
  type        = string
}

variable "keys" {
  description = "Key names"
  type        = list(string)
}

# Optional variables

variable "prevent_destroy" {
  description = "Prevent destroy keys"
  type        = bool
  default     = true
}

variable "set_owners_for" {
  description = "Name of keys for which owners will be set"
  type        = list(string)
  default     = []
}

variable "owners" {
  description = "List of comma-separated encrypters for each key declared in set_owners_for"
  type        = list(string)
  default     = []
}

variable "set_encrypters_for" {
  description = "Name of keys for which encrypters will be set"
  type        = list(string)
  default     = []
}

variable "encrypters" {
  description = "List of comma-separated encrypters for each key declared in set_encrypters_for"
  type        = list(string)
  default     = []
}

variable "set_decrypters_for" {
  description = "Name of keys for which decrypters will be set"
  type        = list(string)
  default     = []
}

variable "decrypters" {
  description = "List of comma-separated decrypters for each key declared in set_decrypters_for"
  type        = list(string)
  default     = []
}

variable "key_rotation_period" {
  description = "Rotation period"
  type        = string
  default     = "100000s"
}

variable "key_algorithm" {
  description = "Algorithm to use, see https://cloud.google.com/kms/docs/reference/rest/v1/CryptoKeyVersionAlgorithm for possible inputs"
  type        = string
  default     = "GOOGLE_SYMMETRIC_ENCRYPTION"
}

variable "key_protection_level" {
  description = "Protection level to use, possible values: [\"SOFTWARE\", \"HSM\"]"
  type        = string
  default     = "SOFTWARE"
}

variable "labels" {
  description = "Labels, provided as a map"
  type        = map(string)
  default     = {}
}