locals {
  bindings_by_role = distinct([
    for binding in var.bindings :
    {
      entity = binding.entity,
      role = binding.role,
      members = distinct(flatten(binding.members)),
      mode = binding.mode
    }
  ])

  bindings_by_member = distinct(flatten([
    for binding in local.bindings_by_role :
    [
      for member in binding.members :
      {
        entity = binding.entity,
        role = binding.role,
        member = member,
        mode = binding.mode
      }
    ]
  ]))

  bindings = {
    for binding in local.bindings_by_role :
    format("%s--%s", lower(binding.entity), lower(binding.role)) => binding
    if binding.mode == "authoritative"
  }

  bindings_additive = {
    for binding in local.bindings_by_member :
    format("%s--%s--%s", lower(binding.entity), lower(binding.role), lower(binding.member)) => binding
    if binding.mode == "additive"
  }
}
