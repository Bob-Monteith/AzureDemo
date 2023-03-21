## Virtual Machine
output "windows_computer_name" {
  description = "Hostname of the Windows virtualmachine"
  value       = local.virtual_machine_windows && !var.migration && !var.orchestration_dry_run ? azurerm_windows_virtual_machine.virtualmachine_windows[0].computer_name : null
}

output "linux_computer_name" {
  description = "Hostname of the Linux virtualmachine"
  value       = local.virtual_machine_linux && !var.migration && !var.orchestration_dry_run ? azurerm_linux_virtual_machine.virtualmachine_linux[0].computer_name : null
}

output "rehosted_vm" {
  description = "Details of the Re-Hosted virtualmachine"
  value       = var.migration && !var.orchestration_dry_run ? azapi_resource.virtualmachine_rehosted[0] : null
}
## Gallery
output "image_template" {
  description = "Details of the Image"
  value       = var.image_template
}
output "image_plan" {
  description = "Details of the Image plan for linux"
  value       = local.image_plan
}

output "azurerm_shared_image_version" {
  description = "Details of the Image template version being used"
  value       = local.management_gallery_image
}
output "management_subscriptionid" {
  description = "Details of the Management Subscription"
  value       = local.management_subscriptionid
}

output "management_gallery_group_name" {
  description = "Details of the Resouce Group Image gallery being used"
  value       = format("%s%s", module.gallery_names.resource_group_name, var.gallery_object_index)
}

output "management_gallery_name" {
  description = "Details of the Image gallery being used"
  value       = format("%s%s", module.gallery_names.image_gallery_name, var.gallery_object_index)
}

output "virtual_machine_resource_group_name" {
  description = "Details of the machine resource group"
  value       = format("%s%s", module.machine_names.resource_group_name, var.resource_group_object_index)
}

output "virtual_machine_name" {
  description = "Details of the machine resource group"
  value       = local.virtual_machine_name
}

output "virtual_machine_resource_group_name-asr" {
  description = "Details of the machine resource group ASR"
  value       = format("%s%s-asr", module.machine_names.resource_group_name, var.resource_group_object_index)
}

## Disks
output "disks" {
  description = "Details disk configuration used"
  value       = !var.orchestration_dry_run ? module.vm_disks[*].diskid : null
}

output "rehosted_disks" {
  description = "Details disk configuration used"
  value       = !var.orchestration_dry_run ? module.vm_migrated_disks[*].diskid : null
}

output "availability_zone" {
  description = "Details disk configuration used"
  value       = local.disk_zonal && !var.orchestration_dry_run ? format("%s and secondary %s", local.primary_zone, local.secondary_zone) : "None"
}
output "virtual_machine_id" {
  description = "virtual_machine_id used"
  value       = !var.orchestration_dry_run ? local.virtual_machine_id : null
}
## Network information
output "network_resource_group_name" {
  description = "Name of the Network Resource Group"
  value       = format("%s%s", module.network_names.resource_group_name, var.network_object_index)
}

output "azurerm_virtual_network" {
  description = "Details of the Network"
  value       = !var.orchestration_dry_run ? data.azurerm_virtual_network.vnet : null
}

output "azurerm_virtual_network_name" {
  description = "Name of the Network"
  value       = format("%s%s", module.network_names.virtual_network_name, var.network_object_index)
}

output "azurerm_subnet" {
  description = "Details of the Network Subnet"
  value       = !var.orchestration_dry_run ? data.azurerm_subnet.subnet : null
}

output "azurerm_subnet_name" {
  description = "Name of the Network Subnet"
  value       = local.virtual_network_subnet
}
output "virtual_network_classification" {
  description = "Classification"
  value       = local.virtual_network_classification
}

output "network_interface" {
  description = "Details of the Network Interface"
  value       = !var.orchestration_dry_run ? azurerm_network_interface.virtualmachine : null
}

output "data_collection_rule" {
  description = "data_collection_rule used"
  value       = local.data_collection_rule
}

output "support_backup_policy_name" {
  description = "support backup policy name"
  value       = local.support_backup_policy
}

output "support_backup_vault" {
  description = "support backup policy"
  value       = local.backup ? data.azurerm_recovery_services_vault.vault[0].id : ""
}

output "support_backup_policy_id" {
  description = "support backup policy"
  value       = local.backup ? data.azurerm_backup_policy_vm.policy[0].id : ""
}

output "support_backup_file_policy" {
  description = "support backup filepolicy"
  value       = local.workload_backup && local.virtual_machine_linux ? data.azurerm_recovery_services_vault.filevault[0].name : ""
}

output "site_recovery_replicated_vm_id" {
  description = "The ID of the Site Recovery Replicated VM."
  value       = local.disaster_recovery && !var.orchestration_dry_run ? azurerm_site_recovery_replicated_vm.protected_vm_tf[0].id : ""
}
output "rehosted_data_disks_order" {
  description = "The disk order of all disks to be added."
  value       = var.migration ? local.hosted_data_disks : null
}