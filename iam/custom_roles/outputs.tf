output "custom_roles_org" {
  value       = local.custom_roles_org
  description = "Oorganisation level custom roles managed by the module."
}

output "custom_roles_project" {
  value       = merge(local.custom_roles_project, local.default_custom_roles_project)
  description = "Project level custom roles managed by the module."
}
