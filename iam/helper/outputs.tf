output "bindings_by_role" {
  value       = local.bindings_by_role
  description = "List of bindings unwinded by role"
}

output "bindings_by_member" {
  value       = local.bindings_by_member
  description = "List of bindings unwinded by members."
}

output "bindings" {
  value       = local.bindings
  description = "Map of map of bindings with appropriate keys"
}

output "bindings_additive" {
  value       = local.bindings_additive
  description = "Map of map of bindings with appropriate keys"
}
