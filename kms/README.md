# Module GCP KMS

__Adapted from [terraform-google-modules](https://github.com/terraform-google-modules/terraform-google-kms) with a little modification__

Simple Cloud KMS module that allows managing:

- one KMS keyring in the provided project
- zero or more keys in the keyring
- IAM role bindings for owners, encrypters, decrypters


## Prerequisites

### Required API Service:

Google Cloud Key Management Service: `cloudkms.googleapis.com`

### Required roles:

Cloud KMS Admin: `roles/cloudkms.admin` or Owner: `roles/owner`

## Example Usage
```
module "kms" {
  source  = "../terragrunt-module-gcp-kms"

  project_id         = "<PROJECT ID>"
  location           = "US"
  keyring            = "sample-keyring"
  keys               = ["foo", "spam"]
  set_owners_for     = ["foo", "spam"]
  owners = [
    "group:one@example.com,group:two@example.com",
    "group:one@example.com",
  ]
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| project\_id | Project id where the keyring will be created. | string | n/a | yes |
| location | Location for the keyring. | string | n/a | yes |
| keyring | Keyring name. | string | n/a | yes |
| keys | Key names. | list(string) | n/a | yes |
| key\_algorithm | The algorithm to use when creating a version based on this template. See the https://cloud.google.com/kms/docs/reference/rest/v1/CryptoKeyVersionAlgorithm for possible inputs. | string | `"GOOGLE_SYMMETRIC_ENCRYPTION"` | no |
| key\_protection\_level | The protection level to use when creating a version based on this template. Possible values: ["SOFTWARE", "HSM"] | string | `"SOFTWARE"` | no |
| key\_rotation\_period |  | string | `"100000s"` | no |
| prevent\_destroy | Set the prevent_destroy lifecycle attribute on keys. | string | `"true"` | no |
| owners | List of comma-separated owners for each key declared in set_owners_for. | list(string) | `<list>` | no |
| set\_owners\_for | Name of keys for which owners will be set. | list(string) | `<list>` | no |
| encrypters | List of comma-separated owners for each key declared in set_encrypters_for. | list(string) | `<list>` | no |
| set\_encrypters\_for | Name of keys for which encrypters will be set. | list(string) | `<list>` | no |
| decrypters | List of comma-separated owners for each key declared in set_decrypters_for. | list(string) | `<list>` | no |
| set\_decrypters\_for | Name of keys for which decrypters will be set. | list(string) | `<list>` | no |
| labels | Labels, provided as a map | map(string) | `<map>` | no |

## Outputs

| Name | Description |
|------|-------------|
| keyring\_resource | Keyring resource. |
| keys | Map of key name => key self link. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->


## TODO
auto-gen docs
CI/CD and tests