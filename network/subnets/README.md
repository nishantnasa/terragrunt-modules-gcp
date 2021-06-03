# terragrunt-module-gcp-network/subnets

This module creates the individual vpc subnets.

It supports creating:

- Subnets within vpc network.

## Usage

Basic usage of this submodule is as follows:

```hcl
module "subnet" {
    source  = "../subnets"

    project_id   = "<PROJECT ID>"
    network_name = "example-vpc"

    subnets = [
        {
            name           = "subnet-01"
            ip             = "10.10.10.0/24"
            region         = "us-west1"
        },
        {
            name           = "subnet-02"
            ip             = "10.10.20.0/24"
            region         = "us-west1"
            private_access = "true"
            flow_logs      = "true"
            description           = "This subnet has a description"
        },
        {
            name               = "subnet-03"
            ip                 = "10.10.30.0/24"
            region             = "us-west1"
            low_logs          = "true"
            flow_logs_interval = "INTERVAL_10_MIN"
            flow_logs_sampling = 0.7
            flow_logs_metadata = "INCLUDE_ALL_METADATA"
        }
    ]

    secondary_ranges = {
        subnet-01 = [
            {
                range_name    = "subnet-01-secondary-01"
                ip_cidr_range = "192.168.64.0/24"
            },
        ]

        subnet-02 = []
    }
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| network\_name | The name of the network where subnets will be created | string | n/a | yes |
| project\_id | The ID of the project where subnets will be created | string | n/a | yes |
| secondary\_ranges | Secondary ranges that will be used in some of the subnets | object | `<map>` | no |
| subnets | The list of subnets being created | list(map(string)) | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| subnets | The created subnet resources |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

### Subnet Inputs

The subnets list contains maps, where each object represents a subnet. Each map has the following inputs (please see examples folder for additional references):

| Name                         | Description                                                                                                     |  Type  |         Default          | Required |
| ---------------------------- | --------------------------------------------------------------------------------------------------------------- | :----: | :----------------------: | :------: |
| name                 | The name of the subnet being created                                                                            | string |            -             |   yes    |
| ip                   | The IP and CIDR range of the subnet being created                                                               | string |            -             |   yes    |
| region               | The region where the subnet will be created                                                                     | string |            -             |   yes    |
| private\_access      | Whether this subnet will have private Google access enabled                                                     | string |        `"false"`         |    no    |
| flow\_logs           | Whether the subnet will record and send flow log data to logging                                                | string |        `"false"`         |    no    |
| flow\_logs\_interval | If flow\_logs is true, sets the aggregation interval for collecting flow logs                           | string |    `"INTERVAL_5_SEC"`    |    no    |
| flow\_logs\_sampling | If flow\_logs is true, set the sampling rate of VPC flow logs within the subnetwork                     | string |         `"0.5"`          |    no    |
| flow\_logs\_metadata | If flow\_logs is true, configures whether metadata fields should be added to the reported VPC flow logs | string | `"INCLUDE_ALL_METADATA"` |    no    |
