# Project APIs Activation

This module is used to enable project API services in a GCP project. The list of
APIs to be enabled is specified using the `activate_apis` variable.

This module uses the [`google_project_service`](https://www.terraform.io/docs/providers/google/r/google_project_service.html)
resource, which is  _non-authoritative_, as opposed to the [`google_project_services`](https://www.terraform.io/docs/providers/google/r/google_project_services.html)
resource, which is _authoritative_. Authoritative in this case means that services
that are not defined in the config will be removed, or disabled, in the project.
In practice, this is dangerous because it is fairly easy to inadventently disable
APIs without knowing it. Therefore, it is recommended to avoid using
[`google_project_services`], and to use [`google_project_service`] instead.


## Prerequisites

1. Service account used to run Terraform has permissions to manage project APIs:
[`roles/serviceusage.serviceUsageAdmin`](https://cloud.google.com/iam/docs/understanding-roles#service-usage-roles) or [`roles/owner`](https://cloud.google.com/iam/docs/understanding-roles#primitive_role_definitions)

## Example Usage
```
module "project-services" {
  source  = "../project_services"

  project_id                  = "my-project-id"

  activate_apis = [
    "compute.googleapis.com",
    "iam.googleapis.com",
  ]
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
