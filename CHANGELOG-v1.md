### [1.0.73](https://github.axa.com/ago-sharedtferegistry/terraform-azure-vm/tree/1.0.73) - (2021-12-09)
#### Updated
- Support module can not be pre-prod
### [1.0.70](https://github.axa.com/ago-sharedtferegistry/terraform-azure-vm/tree/1.0.70) - (2021-12-09)
#### Fixed
- Only care about VM backup cannot backup SQL
- syslog logs
### [1.0.67](https://github.axa.com/ago-sharedtferegistry/terraform-azure-vm/tree/1.0.67) - (2021-12-03)
#### Fixed
- Only care about VM backup cannot backup SQL
### [1.0.66](https://github.axa.com/ago-sharedtferegistry/terraform-azure-vm/tree/1.0.66) - (2021-12-03)
#### Fixed
- Case on backup policy
### [1.0.65](https://github.axa.com/ago-sharedtferegistry/terraform-azure-vm/tree/1.0.65) - (2021-12-03)
#### Fixed
- Additional disk logic for SQL and Oracle
### [1.0.64](https://github.axa.com/ago-sharedtferegistry/terraform-azure-vm/tree/1.0.64) - (2021-11-30)
##### ADDED :tada:
- SystemAssigned The Managed Service Identity Type of this Virtual Machine
### [1.0.62](https://github.axa.com/ago-sharedtferegistry/terraform-azure-vm/tree/1.0.62) - (2021-11-30)
##### ADDED :tada:
- Fixed lock and VM extension
### [1.0.55](https://github.axa.com/ago-sharedtferegistry/terraform-azure-vm/tree/1.0.60) - (2021-11-30)
##### ADDED :tada:
- Added VM extension to the VM
### [1.0.54](https://github.axa.com/ago-sharedtferegistry/terraform-azure-vm/tree/1.0.51) - (2021-11-26)
#### Fixed
- az config set extension.use_dynamic_install=yes_without_prompt.
### [1.0.52](https://github.axa.com/ago-sharedtferegistry/terraform-azure-vm/tree/1.0.51) - (2021-11-26)
##### ADDED :tada:
- Data collection rule association this requires an update to VM support module to be deployed.
### [1.0.51](https://github.axa.com/ago-sharedtferegistry/terraform-azure-vm/tree/1.0.51) - (2021-11-23)
##### ADDED :tada:
- More flexible backup options for multiple vaults.
### [1.0.50](https://github.axa.com/ago-sharedtferegistry/terraform-azure-vm/tree/1.0.50) - (2021-11-23)
#### Fixed
- VM Backup resource group.
### [1.0.47](https://github.axa.com/ago-sharedtferegistry/terraform-azure-vm/tree/1.0.47) - (2021-11-18)
#### Fixed
- VM Backup policy functionality.
### [1.0.42](https://github.axa.com/ago-sharedtferegistry/terraform-azure-vm/tree/1.0.42) - (2021-11-18)
##### ADDED :tada:
- VM Backup policy functionality.
### [1.0.41](https://github.axa.com/ago-sharedtferegistry/terraform-azure-vm/tree/1.0.41) - (2021-11-17)
##### ADDED :tada:
- VM Tag for backup policy.
### [1.0.40](https://github.axa.com/ago-sharedtferegistry/terraform-azure-vm/tree/1.0.40) - (2021-11-10)
#### Fixed
- Resource lock on Linux VMs as this was missing depends on.
### [1.0.39](https://github.axa.com/ago-sharedtferegistry/terraform-azure-vm/tree/1.0.39) - (2021-11-09)
#### Fixed
- Enforced dataclass to use Camel case as the API is case sensitive
### [1.0.37](https://github.axa.com/ago-sharedtferegistry/terraform-azure-vm/tree/1.0.37) - (2021-11-08)
#### Fixed
- VM Disk Zone another fix disks don't support zone 0
### [1.0.36](https://github.axa.com/ago-sharedtferegistry/terraform-azure-vm/tree/1.0.36) - (2021-11-05)
#### Fixed
- VM Disk Zone another fix
### [1.0.35](https://github.axa.com/ago-sharedtferegistry/terraform-azure-vm/tree/1.0.36) - (2021-11-04)
#### Fixed
- VM Disk Zones
### [1.0.35](https://github.axa.com/ago-sharedtferegistry/terraform-azure-vm/tree/1.0.35) - (2021-10-20)
##### ADDED :tada:
- Fixed the tag for axa role
### [1.0.34](https://github.axa.com/ago-sharedtferegistry/terraform-azure-vm/tree/1.0.34) - (2021-10-30)
##### ADDED :tada:
- Ability to have resource group name differ from vm names in terms of application/project
### [1.0.32](https://github.axa.com/ago-sharedtferegistry/terraform-azure-vm/tree/1.0.32) - (2021-10-29)
##### ADDED :tada:
- Added network_environment_index and network_object_index variables to allow multiple Network spokes
- Added resource_group_object_index variable to allow multiple Workload resource groups
- Added local-vmprovisioningid to keep track of an occurrence of vm lifecycle
### [1.0.31](https://github.axa.com/ago-sharedtferegistry/terraform-azure-vm/tree/1.0.31) - (2021-10-29)
#### Fixed
- Finally got tagging working with lifecycle!
### [1.0.30](https://github.axa.com/ago-sharedtferegistry/terraform-azure-vm/tree/1.0.30) - (2021-10-29)
#### Updated
- Readme for resource group creation
### [1.0.28](https://github.axa.com/ago-sharedtferegistry/terraform-azure-vm/tree/1.0.28) - (2021-10-29)
#### Fixed
- New field short_app_name
### [1.0.27](https://github.axa.com/ago-sharedtferegistry/terraform-azure-vm/tree/1.0.26) - (2021-10-29)
##### ADDED :tada:
- New field short_app_name for VM name so that global-app can be longer than 4 characters
### [1.0.26](https://github.axa.com/ago-sharedtferegistry/terraform-azure-vm/tree/1.0.26) - (2021-10-28)
#### Fixed
- Ignore tags was still an issue
### [1.0.25](https://github.axa.com/ago-sharedtferegistry/terraform-azure-vm/tree/1.0.25) - (2021-10-28)
##### ADDED :tada:
- Tag to quickly see os_type
### [1.0.24](https://github.axa.com/ago-sharedtferegistry/terraform-azure-vm/tree/1.0.24) - (2021-10-28)
##### Changed
- global-env to only accept development
### [1.0.23](https://github.axa.com/ago-sharedtferegistry/terraform-azure-vm/tree/1.0.23) - (2021-10-27)
##### ADDED :tada:
- Optional Event grid to force the creation of an event grid before VMs are built
### [1.0.22](https://github.axa.com/ago-sharedtferegistry/terraform-azure-vm/tree/1.0.22) - (2021-10-26)
#### Fixed
- Lifecycle tag ignore for vm provisioning tags
### [1.0.19](https://github.axa.com/ago-sharedtferegistry/terraform-azure-vm/tree/1.0.19) - (2021-10-26)
#### Fixed
- Dependencies
### [1.0.18](https://github.axa.com/ago-sharedtferegistry/terraform-azure-vm/tree/1.0.18) - (2021-10-22)
#### Fixed
- Fixed disk config issue with change to axa role
### [1.0.17](https://github.axa.com/ago-sharedtferegistry/terraform-azure-vm/tree/1.0.17) - (2021-10-22)
#### Fixed
- Fixed dynamic to static IP allocation
### [1.0.16](https://github.axa.com/ago-sharedtferegistry/terraform-azure-vm/tree/1.0.16) - (2021-10-22)
#### Fixed
- Fixed disk config issue with change to axa role
### [1.0.15](https://github.axa.com/ago-sharedtferegistry/terraform-azure-vm/tree/1.0.15) - (2021-10-20)
#### Fixed
- Default axa role aas caused issues with Linux puppet install
##### ADDED :tada:
- Readme info about Hyper Threaded VM Families
### [1.0.14](https://github.axa.com/ago-sharedtferegistry/terraform-azure-vm/tree/1.0.14) - (2021-10-15)
#### Fixed
- Ignore tag changes on the NIC.
### [1.0.13](https://github.axa.com/ago-sharedtferegistry/terraform-azure-vm/tree/1.0.13) - (2021-10-15)
#### Fixed
- Default disk configuration logic.
##### ADDED :tada:
- Ability to specify VM availability zone
- Added CanNotDelete resource lock for Network Interface and Virtual Machine
- Changed Windows VM to use Hybrid Benefit by default following FinOps audit

### [1.0.12](https://github.axa.com/ago-sharedtferegistry/terraform-azure-vm/tree/1.0.12) - (2021-10-15)
##### ADDED :tada:
- Child module for handling shutdown schedules and added allow optional shutdown.
- Simplified disk configuration.
- Readme alignment with AXA standard template structure, and rename of tag variables to match convention.
- Increased default VM SKU as it was painfully slow.

### [1.0.11](https://github.axa.com/ago-sharedtferegistry/terraform-azure-vm/tree/1.0.11) - (2021-10-14)
#### Fixed
- Removed the need for lun as this was pointless if it can be auto allocated.

### [1.0.10](https://github.axa.com/ago-sharedtferegistry/terraform-azure-vm/tree/1.0.10) - (2021-10-14)
#### Fixed
- License type None doesn't work needs null.

### [1.0.9](https://github.axa.com/ago-sharedtferegistry/terraform-azure-vm/tree/1.0.9) - (2021-10-14)
##### ADDED :tada:
- Capability for hybrid benefit.
- Child module for handling disks.
- Split mandatory and optional variables in to separate files.

### [1.0.8](https://github.axa.com/ago-sharedtferegistry/terraform-azure-vm/tree/1.0.8) - (2021-10-13)
##### ADDED :tada:
- Capability for default disk configurations based on the role of the VM these can be overridden.

### [1.0.7](https://github.axa.com/ago-sharedtferegistry/terraform-azure-vm/tree/1.0.7) - (2021-10-13)
##### ADDED :tada:
- Updated capability to use Static IP either dynamically switching to Static or Specifying an IP.

### [1.0.6](https://github.axa.com/ago-sharedtferegistry/terraform-azure-vm/tree/1.0.6) - (2021-10-12)
### Fixed
- Static IP to work with terraform null resource allowing dynamic to switch to static.

### [1.0.5](https://github.axa.com/ago-sharedtferegistry/terraform-azure-vm/tree/1.0.5) - (2021-10-11)
#### Added
- Updated tagging for VM role to align with puppet requirements.

### [1.0.4](https://github.axa.com/ago-sharedtferegistry/terraform-azure-vm/tree/1.0.4) - (2021-10-11)
#### Added
- Added VM Status Tag which is used to show a VM is ready to use.

### [1.0.3](https://github.axa.com/ago-sharedtferegistry/terraform-azure-vm/tree/1.0.3) - (2021-10-06)
#### Added
- Added static IP to allow you to specify an IP.

### [1.0.2](https://github.axa.com/ago-sharedtferegistry/terraform-azure-vm/tree/1.0.2) - (2021-10-04)
#### Added
- Removed the need to work out the Virtual Network name now using tags to auto identify this.

### [1.0.1](https://github.axa.com/ago-sharedtferegistry/terraform-azure-vm/tree/1.0.1) (2021-10-03)
#### Added
- Added readme.

### [1.0.0] - (2021-10-03)
#### Changed
- Migrated module from GlobalPatternFactory organization.
