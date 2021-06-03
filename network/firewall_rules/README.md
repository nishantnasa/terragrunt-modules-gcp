# Google Cloud VPC Firewall

This module allows creation of VPC firewall rules.

Firewall rules are set through a map where keys are rule names, and values use this custom type:

```hcl
list(map(object({
  name                 = string
  description          = string
  direction            = string       # (INGRESS|EGRESS)
  action               = string       # (allow|deny)
  ip_ranges            = list(string) # list of IP CIDR ranges
  sources              = list(string) # tags or SAs (ignored for EGRESS)
  targets              = list(string) # tags or SAs
  use_service_accounts = bool         # use tags or SAs in sources/targets
  rules = list(object({
    protocol = string
    ports    = list(string)
  }))
  extra_attributes = map(string)      # map, optional keys disabled or priority
})))
```

The resources created/managed by this module are:

- one or more firewall rules


## Usage

Basic usage of this module is as follows:

```hcl
module "firewall_rules" {
  source                  = "../firewall_rules"
  project_id              = "project-id"
  network                 = "network-name"
  firewall_rules = [
    {
      name                 = "firewall-1000-sample-ingress-allow-ssh"
      description          = "Dummy sample ingress rule."
      direction            = "ingress"
      action               = "allow"
      ip_ranges            = ["192.168.0.0/24"]
      sources              = ["bastion-tag"]
      targets              = ["app-tag", "api-tag"]
      use_service_accounts = false
      rules = [
        {
          protocol = "tcp"
          ports    = [22]
        }
      ]
      extra_attributes = {}
    },
    {
      name                 = "firewall-1000-sample-egress-deny-internet"
      description          = "Dummy sample egress rule."
      direction            = "egress"
      action               = "deny"
      ip_ranges            = ["0.0.0.0/0"]
      targets              = ["private-tag"]
      use_service_accounts = false
      rules = [
        {
          protocol = "tcp"
        }
      ]
      extra_attributes = {
        priority = 9999
      }
    },
    {
      ...
    }
  ]
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| admin\_ranges | IP CIDR ranges that have complete access to all subnets. | list | `<list>` | no |
| admin\_ranges\_enabled | Enable admin ranges-based rules. | string | `"false"` | no |
| custom\_rules | List of custom rule definitions (refer to variables file for syntax). | object | `<map>` | no |
| http\_source\_ranges | List of IP CIDR ranges for tag-based HTTP rule, defaults to 0.0.0.0/0. | list | `<list>` | no |
| https\_source\_ranges | List of IP CIDR ranges for tag-based HTTPS rule, defaults to 0.0.0.0/0. | list | `<list>` | no |
| internal\_allow | Allow rules for internal ranges. | list | `<list>` | no |
| internal\_ranges | IP CIDR ranges for intra-VPC rules. | list | `<list>` | no |
| internal\_ranges\_enabled | Create rules for intra-VPC ranges. | string | `"false"` | no |
| network | Name of the network this set of firewall rules applies to. | string | n/a | yes |
| project\_id | Project id of the project that holds the network. | string | n/a | yes |
| ssh\_source\_ranges | List of IP CIDR ranges for tag-based SSH rule, defaults to 0.0.0.0/0. | list | `<list>` | no |

## Outputs

| Name | Description |
|------|-------------|
| admin\_ranges | Admin ranges data. |
| custom\_egress\_allow\_rules | Custom egress rules with allow blocks. |
| custom\_egress\_deny\_rules | Custom egress rules with allow blocks. |
| custom\_ingress\_allow\_rules | Custom ingress rules with allow blocks. |
| custom\_ingress\_deny\_rules | Custom ingress rules with deny blocks. |
| internal\_ranges | Internal ranges. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
