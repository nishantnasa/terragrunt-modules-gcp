terraform {
  # The configuration for this backend will be filled in by Terragrunt
  backend "gcs" {}

  # Live modules pin exact Terraform version; generic modules let consumers pin the version.
  # The latest version of Terragrunt (v0.19.0 and above) requires Terraform 0.12.0 or above.
  required_version = "> 0.12.6"
}

# Create an instance with OS Login configured to use as a bastion host.

resource "google_compute_instance" "bastion_host" {
  project      = var.project_id
  name         = var.instance_name
  machine_type = var.machine_type
  zone         = var.zone

  tags = var.tags
  labels = var.labels

  boot_disk {
    initialize_params {
      image = var.source_image
    }
  }

  network_interface {
    subnetwork = var.subnetwork
  }

  metadata = {
    enable-oslogin = "TRUE"
  }
}
