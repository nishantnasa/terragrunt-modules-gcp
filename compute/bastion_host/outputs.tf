output "instance" {
  description = "A self_link to the bastion host's VM instance"
  value       = google_compute_instance.bastion_host
}
