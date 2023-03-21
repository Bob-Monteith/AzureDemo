# Changelog
All notable changes to this module will be documented in this file
```
____   _________                       .___    .__
\   \ /   /     \     _____   ____   __| _/_ __|  |   ____
 \   Y   /  \ /  \   /     \ /  _ \ / __ |  |  \  | _/ __ \
  \     /    Y    \ |  Y Y  (  <_> ) /_/ |  |  /  |_\  ___/
   \___/\____|__  / |__|_|  /\____/\____ |____/|____/\___  >
                \/        \/            \/               \/

```
### [version:2.15.0](https://github.axa.com/ago-sharedtferegistry/terraform-azure-vm/tree/2.15.0) - (2023-03-14)
### [MPI Release v1.14.0](https://confluence.axa.com/confluence/x/x7GZF)
##### ADDED :tada:
- Added app_centric variable to allow specification of all extended components for resource group targeting.
- Support for region southeastasia
- New tag `silva_internal_id` used for Puppet.
- BYOS Linux image lookup reference for plan name and postcondition to prevent new VMs to use none BYOS.
- new var `notification_email` which can be used to send an email to a target distribution group on completion of provisioning.
- precondition on data disk size and caching.
##### UPDATED :+
- quickref script to now document sub modules and added line number and module reference note this is an internal cross reference only.
- Virtual machine lock description to get round changes to DCRs.
- change default of global_monitoring to false for non production.
- data collection rule association to use `azurerm_monitor_data_collection_rule_association` rather than azapi
- data_disk_caching variable on data disks default value of ReadWrite for rehosted may need updating to None if you don’t want this change.
- API version `Microsoft.RecoveryServices/vaults/backupFabrics/backupProtectionIntent@2023-01-01`
- API version `Microsoft.Compute/virtualMachines@2022-11-01`
- minimum monitor agent `type_handler_version`
- managed disks to have `network_access_policy` DenyAll
- provider azurerm to v3.46.0
- provider azapi to v1.4.0
##### FIXED :metal:
- Extended fileshare backup.
### [version:2.14.2](https://github.axa.com/ago-sharedtferegistry/terraform-azure-vm/tree/2.14.2) - (2023-03-01)
### [MPI Release v1.12.2](https://confluence.axa.com/confluence/x/zZFZF)
##### UPDATED :+
- regex for `data_disk_size` to allow 1-32767.
### [version:2.14.1](https://github.axa.com/ago-sharedtferegistry/terraform-azure-vm/tree/2.14.1) - (2023-02-20)
### [MPI Release v1.12.1](https://confluence.axa.com/confluence/x/zZFZF)
##### UPDATED :+
- `target_disk_encryption_set_id` to resolve secret and encrypted virtual machines and replication.
### [version:2.14.0](https://github.axa.com/ago-sharedtferegistry/terraform-azure-vm/tree/2.14.0) - (2023-02-14)
### [MPI Release v1.12.0](https://confluence.axa.com/confluence/x/Z7NLF)
##### ADDED :tada:
- `target_capacity_reservation_group_id` to replication.
- random provider for the virtual machine password.
##### UPDATED :+
- SOC logging for prod and pre-prod only
- `data.azurerm_resource_group.virtualmachine.location` to `var.location` stage dependency issue with provider updates 
- azurerm provider to v3.42.0 for azure site recovery changes. 
- azapi provider to v1.3.0
- requirement for minimum terraform version to v1.3.7
### [version:2.13.0](https://github.axa.com/ago-sharedtferegistry/terraform-azure-vm/tree/2.13.0) - (2023-02-01)
### [MPI Release v1.11.0](https://confluence.axa.com/confluence/x/oM4PF)
##### ADDED :tada:
- Secret `global-dataclass` option used for virtual machine encryption
- `enable_notification` alert variable to allow orchestration to send alerts to support team.
- `azurerm_site_recovery_network_mapping` for replication.
##### UPDATED :+
- backup light policy option for database for non production which acts the same as none.
### [version:2.12.1](https://github.axa.com/ago-sharedtferegistry/terraform-azure-vm/tree/2.12.1) - (2023-01-19)
##### REMOVED :tada:
- remove naming module dependency
### [version:2.12.0](https://github.axa.com/ago-sharedtferegistry/terraform-azure-vm/tree/2.12.0) - (2023-01-17)
### [MPI Release v1.10.0](https://confluence.axa.com/confluence/x/AZu1Ew)
##### ADDED :tada:
- Ability to use a custom file share storage account and large file shares with preconditions
- tag global-techserviceid with lookup from JSON file shared to all modules
- More outputs
##### UPDATED :+
- `reserve_capacity` allows any `service_class`
- providers azapi to 1.1.0 and azurerm to 3.35.0
- ##### FIXED :metal:
- Ability to add new disks to a migrated machine
##### REMOVED :tada:
- `mongodb` option for 
### [version:2.11.0](https://github.axa.com/ago-sharedtferegistry/terraform-azure-vm/tree/2.11.0) - (2022-12-06)
### [MPI Release v1.9.0](https://confluence.axa.com/confluence/x/S6tMEw)
##### ADDED :tada:
- Platinum DR class option
- 'os_disk_size_gb' The Size of the Internal OS Disk in GB, if you wish to vary from the size used in the image this Virtual Machine is sourced from.
- ##### UPDATED :+1:
- Updated the provider to support for expanding data disks without downtime
### [version:2.10.0](https://github.axa.com/ago-sharedtferegistry/terraform-azure-vm/tree/2.10.0) - (2022-11-22)
### [MPI Release v1.8.0](https://confluence.axa.com/confluence/x/FGgrEw)
##### ADDED :tada:
- Re-run capability using `orchestration_re_run`
- Ability to add new disks to a rehosted virtual machine using the additional_disk_configuration feature.
##### UPDATED :+1:
- Updated `ignore_changes` on disks for DR failback
### [version:2.9.0](https://github.axa.com/ago-sharedtferegistry/terraform-azure-vm/tree/2.9.0) - (2022-11-08)
### [MPI Release v1.7.0](https://confluence.axa.com/confluence/x/-4oPEw)
##### UPDATED :+1:
- Re-Hosting API Version `Microsoft.Compute/virtualMachines@2022-08-01`
- `azurerm_managed_disk` to include os_type.
- ignore_changes on re-hosted disk size allowing resizing.
- `short_app_name` min length
##### ADDED :tada:
- `data_disk_caching` option for re-hosted data disks ReadOnly and ReadWrite for premium support.
- `accelerated_networking` which by default is false.
### [version:2.8.0](https://github.axa.com/ago-sharedtferegistry/terraform-azure-vm/tree/2.8.0) - (2022-10-25)
### [MPI Release v1.6.0](https://confluence.axa.com/confluence/x/7yvqEg)
##### UPDATED :+1:
- Ability to use application specific capacity built by sub module of support module
- `TFC_RUN_ID` tag to identify the original run so the user can be contacted. (will be mandatory in the future)
- UAT environment
##### ADDED :tada:
- Lookups to use JSON files to make them more portable but also allowing submodules to use rather than code repetition.
- tag `exposure` to be lower case for orchestration calls.
- Regex for `global-cbp` to allow AA0000 and A00000
##### REMOVED :octocat:
- Pre conditions for backups on DR gold
- Pre conditions for static IP to allow dynamic to static switching

### [version:2.7.0](https://github.axa.com/ago-sharedtferegistry/terraform-azure-vm/tree/2.7.0) - (2022-09-15)
### [MPI Release v1.5.0](https://confluence.axa.com/confluence/x/bO8aEg)
##### ADDED :tada:
- Mandatory hybrid benefit for Windows_Server
- Ability for dry running virtual machine validation
- Ability for orchestration resume for a virtual machine
- Requirement to use Terraform v1.2.4 and later to allow preconditions
- precondition requirement for using `private_ip_address` with DR Gold or Bronze
- precondition requirement for using `reserve_capacity` with Production and DR Gold
- Optional naming component `vm_name` for virtual machines
- Lifecycle precondition checks to validate inputs and to reduce complexity of forcing settings due to possible misconfiguration.
- Script for generating terraform files from csv input
- Ability to connect virtual machine to the additional DR infrastructure supported by the support module
- File shares to cater for Linux and where backups true not just Oracle
- File share backup integration using backup policy and associated Azure Site Recovery Vaults
- Additional outputs allowing e.g. `for k, vm in module.terraform-azure-vm : k => vm.azurerm_virtual_network_name`
- Global monitoring to send logs `global_monitoring`
##### UPDATED :+1:
- `TFC_WORKSPACE_SLUG` now mandatory as this will be sent to SILVA
- Provider to use the >= version constraint syntax
- Provider azurerm to 3.22.0
- `virtual_network_classification` logic to ensure dev is always PIC
- API `Microsoft.Compute/virtualMachines@2022-03-01`
- API `Microsoft.RecoveryServices/vaults/backupFabrics/backupProtectionIntent@2022-03-01`
- variable case inconsistencies to now cater for lower, UPPER and Title
- data use of `azurerm_virtual_network` instead of relying on tag
- ##### FIXED :metal:
- Re-hosting disaster recovery disk recreation using local `virtual_machine_manged_os_disk` and `virtual_machine_manged_data_disks`
- Encryption timing using wait_10_seconds to allow policy to apply in time.
##### REMOVED :octocat:
- `azurerm_key_vault_access_policy` used for encryption as this can only be set once and not per Virtual Machine (requires manual config)
- `hybrid_benefit` option as this is now enforced
- `private_ip_address_allocation` not needed anymore no dynamic to static required
- `subnet_routable` as non routable no longer has a use case
### [version:2.6.2](https://github.axa.com/ago-sharedtferegistry/terraform-azure-vm/tree/2.6.2) - (2022-08-11)
### [MPI Release v1.4.1](https://confluence.axa.com/confluence/x/6vsaEg)
##### UPDATED :+1:
- Fix for Rehosting Pipeline:  re-hosted replication of data disks
### [version:2.6.1](https://github.axa.com/ago-sharedtferegistry/terraform-azure-vm/tree/2.6.1) - (2022-07-20)
### [MPI Release v1.3.0](https://confluence.axa.com/confluence/x/HV7yEQ)
##### UPDATED :+1:
- Capacity reservation for Windows and Linux VMs that use DR Gold not just Re-hosting scenario
- azurerm to version = "=3.13.0" to support `capacity_reservation_group_id`
- Global Data Collection rules to only be used for Production
### [version:2.6.0](https://github.axa.com/ago-sharedtferegistry/terraform-azure-vm/tree/2.6.0) - (2022-07-07)
### [MPI Release v1.2.1](https://confluence.axa.com/confluence/x/rRTHEQ)
##### ADDED :tada:
- Readme file for DB file share
- Capacity reservation variable for re-hosted VMs
- Ability to join Management Virtual Network
- Access policy required for encryption for the VM being deployed
- Ability to use external exposure
##### UPDATED :+1:
- Data collection rules to do Local and Global for new Virtual Machines and only Global for Re-hosted
- Provider azurerm to 3.12.0 to support `azurerm_data_protection_resource_guard`
- Provider azapi to 0.4.0
- Regex for appserviceid as no dashes
- data references to only reference when needed.
##### FIXED :metal:
- issue on production backup policy using none
##### REMOVED :octocat:
- TFC_RUN_ID as this caused much noise and many issues.
- Global logging for re-hosted Virtual Machines
- Excessive dependencies
- UltraSSD disk option for data disks.
### [version:2.5.1](https://github.axa.com/ago-sharedtferegistry/terraform-azure-vm/tree/2.5.1) - (2022-06-10)
##### FIXED :metal:
- issue on production backup policy using none
### [version:2.5.0](https://github.axa.com/ago-sharedtferegistry/terraform-azure-vm/tree/2.5.0) - (2022-06-07)
##### ADDED :tada:
- Provider azapi to 0.3.0
- Support for application spokes
- File share added for Linux and oracle
##### UPDATED :+1:
- Re-hosting a VM no longer uses azurerm provider
- Allowed VM sizes restricted to (Standard_D*, Standard_E*, Standard_F*) and to block Promo
- Windows Data disks to Initialize-Disk -PartitionStyle MBR
- Disaster recovery index changed from 02 to 90 to cater for additional backup vaults
- DCRs to use azapi_resource
- Example files in documentation updated
- Provider azurerm to 3.9.0
- Moved local-orchestration tag to own tag as it was part of local-configuration and this could be a length issue
##### REMOVED :octocat:
- need for CLIENT_SECRET
- shutdown_timezone variable as now using a lookup based on your location
### [version:2.4.0](https://github.axa.com/ago-sharedtferegistry/terraform-azure-vm/tree/2.4.0) - (2022-04-22)
##### ADDED :tada: :tada:
- additional auto tags for backup bd provisioning
- quickref script for self checking module variables and documentation
- `azurerm_virtual_machine_extension` to prepare windows disks for DR gold
- DR Bronze to enforce zonal disks and virtual machines
- static ip to DR Gold
- hybrid_benefit to re-hosted Virtual Machines
- provisioning tags to re-hosted Virtual Machines
##### UPDATED :+1:
- 3.2 of the Azure Provider
- Disk references for `azurerm_site_recovery_replicated_vm`
- Default computer name to hostname
- type_handler_version on Monitoring agents
##### REMOVED :octocat:
- run_id from Vm tags as this was the cause of re-hosting recreation.
- extra dependencies to simplify the upstream.
### [version:2.3.0](https://github.axa.com/ago-sharedtferegistry/terraform-azure-vm/tree/2.3.0) - (2022-04-05)
##### ADDED :tada: :tada:
- New tag for orchestration features
- New tag section for deployment to avoid the maximum length for a tag value is 256 characters
- Re-hosted Virtual Machine resource type
- hyper_v_generation to cater for re-hosting
- Data source to access information about existing snapshots
- Managed disks for re-hosted OS disk
- New file for extensions
- Encryption enforcement for Secret global-dataclass although network doesn't exist.
- TFC_WORKSPACE_SLUG and TFC_RUN_ID to all examples these fields helps track source deployments
##### UPDATED :+1:
- Migration to 3.0 of the Azure Provider which is a major version https://github.com/hashicorp/terraform-provider-azurerm/blob/main/CHANGELOG.md#300-march-24-2022
- Breaking change OS Disk names to allow data resource for DR this will force a rebuild of OS Disk
- Disks to align with zonal changes and availability_zones option.
- Disk module to cater for re-hosted disks
- Data collection rules to use variables rather than a provider
- Backup tagging logic to cater for production enforcement
- Logic for support module environment index to allow multiple like landing zones.
- All components to cater for re-hosting
- renamed optional variables file and removed unused variables and re-layed out files
- Tagging logic to cater for a re-hosted VM
- Encryption key size to 3072
##### REMOVED :octocat:
- Providers and data gallery to cater for using for-each for multiple VMs
- Validation on image template so that re-hosting can be achieved
### [version:2.2.6](https://github.axa.com/ago-sharedtferegistry/terraform-azure-vm/tree/2.1.6) - (2022-03-11)
##### ADDED :tada: :tada:
- db2 role and disk configuration
### [version:2.1.0](https://github.axa.com/ago-sharedtferegistry/terraform-azure-vm/tree/2.1.0) - (2022-02-15)
##### ADDED :tada: :tada:
- Data disk encryption using VM specific disk encryption set (must add SPN to access policy)
- Resource lock for disk encryption set
- Migratable Virtual Machine which configures logging, backup, DR and encryption
- Configuration tags identifying for TFE workspace and run
- Default backup to basic in production if set to none or light
- Tag for availability zone to be passed to Silva
#### Updated
- Encryption dependency for encryption-disk
- All Virtual machine disks to now use StandardSSD_LRS as standard
- Moved tags so that disks and nic are not tagged with vm data.
- Readme now references a user guide to break instructions up into focused topics.
#### Removed
- backup_environment_index as it should align to support index
### [version:2.0.10](https://github.axa.com/ago-sharedtferegistry/terraform-azure-vm/tree/2.0.10) - (2022-01-31)
##### ADDED :tada: :tada:
- Virtual machine storage account type for OS now supports Standard_LRS, StandardSSD_LRS and Premium_LRS
- Disk storage account type now support Standard_LRS, StandardSSD_ZRS, Premium_LRS, Premium_ZRS, StandardSSD_LRS or UltraSSD_LRS.
- Overhauled disks by adding additional disk configuration to default disk configuration (default allows data disk sizing only).
- Removed private_ip_switch as dynamic to static has no use case.
### Fixed
- typo on Pre-Production
- Updated DCRs to use support_set4 not resource_set4
### [version:2.0.8](https://github.axa.com/ago-sharedtferegistry/terraform-azure-vm/tree/2.0.8) - (2022-01-20)
#### Updated
- global-appserviceid is now mandatory with no default.
### [version:2.0.7](https://github.axa.com/ago-sharedtferegistry/terraform-azure-vm/tree/2.0.7) - (2022-01-19)
#### Updated
- Rename of data collection rules to include environment set 4
### [version:2.0.6](https://github.axa.com/ago-sharedtferegistry/terraform-azure-vm/tree/2.0.6) - (2022-01-18)
#### Updated
- Module version tagging
### [2.0.5](https://github.axa.com/ago-sharedtferegistry/terraform-azure-vm/tree/2.0.5) - (2022-01-14)
#### Updated
- appserviceid to default to c048a0d91b8145d4e03f2024b24bcbd4
- removed subnet_exposure external as not to be used for MVP
### [2.0.1](https://github.axa.com/ago-sharedtferegistry/terraform-azure-vm/tree/2.0.1) - (2022-01-12)
#### Updated
- dr_serviceclass to default to None
### [2.0.0](https://github.axa.com/ago-sharedtferegistry/terraform-azure-vm/tree/2.0.0) - (2022-01-07)
##### ADDED :tada:
- Support for Switzerland North and Switzerland West
- Support for Puppet branch using new variable Puppet branch
- Work out management subscription from Tenant id
- Requirement for support module resource group name to cater for more flexibility
- LifeCycle ignore VM image
- Environment mapping lookup for set 4 for network and support
#### Updated
- Specify a location meaning location_code is removed this is used to help match support components
- enable_shutdown is now set to false you must set this to true now or VMs will remain on
#### Fixed
- global-env is now Pascal Case to match Orchestration API
- depends_on for recovery services vault to fix backup bug
