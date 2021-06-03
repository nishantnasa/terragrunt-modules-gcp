output "service_accounts" {
  description = "Map of User Managed Service Accounts."
  value       = {
    for sa in var.service_accounts :
    sa.key => google_service_account.service_account[sa.key]
  }
}
