output "bound_entities" {
  value       = distinct(module.helper.bindings_by_member[*].entity)
  description = "Entities which received bindings."
}

output "bound_roles" {
  value       = distinct(module.helper.bindings_by_member[*].role)
  description = "Roles which were bound to members using this module."
}

output "bound_members" {
  value       = distinct(module.helper.bindings_by_member[*].member)
  description = "Members which were bound to roles using this module."
}

output "bindings_by_role" {
  value       = module.helper.bindings_by_role
  description = "Entity bindings by role."
}

output "bindings_by_member" {
  value       = module.helper.bindings_by_member
  description = "Entity bindings by member."
}
