output "registry_repositories" {
  description = "Map of Artifact Registry Repositories."
  value       = {
    for repo in var.registry_repositories :
    repo.name => google_artifact_registry_repository.this[repo.name]
  }
}
