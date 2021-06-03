variable custom_roles {
  description = "list of custom roles to be created"
  type = list(object({
    target_level  = string # <project/org>
    target_id     = string # Project or Org ID
    role_id       = string # ID of the Custom Role
    title         = string # Human-readable title of the Custom Role, defaults to role_id
    description   = string # Description of Custom role
    permissions   = list(list(string)) # IAM permissions assigned to Custom Role
    stage         = string # The current launch stage of the role, defaults to "GA"
  }))
}

# Default Custom Role Variables
variable "project_id" {
  description = "The ID of the project where the default custom roles will be created"
}

variable default_custom_roles_project {
  description = "list of default custom roles that need to exist in all wowx gcp projects"
  type = list(object({
    role_id       = string # ID of the Custom Role
    title         = string # Human-readable title of the Custom Role, defaults to role_id
    permissions   = list(list(string)) # IAM permissions assigned to Custom Role
    stage         = string # The current launch stage of the role, defaults to "GA"
  }))
  default = []
}
