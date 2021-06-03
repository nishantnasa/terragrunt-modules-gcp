# Module Nat Gateway
Cloud NAT allows instances without an external IP address to access the Internet.
Module creates a single Nat Gateway with a router for GCP project (one Nat Gateway per region on each network).

## Usage
The usage of the module with automatic ip allocation:
```
module "nat_1" {
  source     = ""
  region     = "<REGION>"
  network    = "<NETWORK NAME>"
  subnetwork = "<SUBNETWORK NAME>"
  name       = "<NAT GATEWAY NAME>"
  router     = "<ROUTER NAME>"
}
```

The usage of the module with manual ip allocation with static ip:
```
resource "google_compute_address" "nat_ip_address" {
  name   = "nat-ip"
  region = "us-central1"
}

module "nat_2" {
  source     = ""
  region     = "<REGION>"
  network    = "<NETWORK NAME>"
  subnetwork = "<SUBNETWORK NAME>"
  name       = "<NAT GATEWAY NAME>"
  router     = "<ROUTER NAME>"
  nat_ip_allocate_option = "MANUAL_ONLY"
  nat_ips                = google_compute_address.nat_ip_address.*.self_link
}

```