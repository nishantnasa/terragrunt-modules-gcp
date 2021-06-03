output "project_number" {
  value = data.google_project.project.number
}

output "default_compute_sa" {
  value = lookup(data.google_compute_default_service_account.default,  "compute_engine", null)

  depends_on = [
    data.google_compute_default_service_account.default
  ]
}

output "default_storage_transfer_sa" {
  value = lookup(data.google_storage_transfer_project_service_account.default,  "storage_transfer", null)

  depends_on = [
    data.google_storage_transfer_project_service_account.default
  ]
}
