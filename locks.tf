# Resource locks require the SPN To have Owner on the resource group or Subscription

resource "azurerm_management_lock" "virtual_machines" {
  count      = !var.orchestration_dry_run ? 1 : 0
  name       = "virtual_machine_lock"
  scope      = local.virtual_machine_id
  lock_level = "CanNotDelete"
  notes      = "Locked because it's managed by Terraform (updated)"
  depends_on = [
    #azurerm_windows_virtual_machine.virtualmachine_windows,
    #   azurerm_linux_virtual_machine.virtualmachine_linux,
    #    azapi_resource.virtualmachine_rehosted,
    azurerm_virtual_machine_extension.virtualmachine_linux,
    azurerm_virtual_machine_extension.virtualmachine_windows,
    #   azurerm_virtual_machine_extension.virtualmachine_initialize_windows_disks,
    #    azurerm_site_recovery_replicated_vm.protected_vm_tf,
    module.vm_logs,
    module.vm_schedule
  ]
}

resource "azurerm_management_lock" "network_interface" {
  count      = !var.orchestration_dry_run ? 1 : 0
  name       = "network_interface_lock"
  scope      = azurerm_network_interface.virtualmachine[0].id
  lock_level = "CanNotDelete"
  notes      = "Locked because it's managed by Terraform"
}

resource "azurerm_management_lock" "encryption_set" {
  count      = var.encryption && !var.orchestration_dry_run ? 1 : 0
  name       = "encryption_set_lock"
  scope      = azurerm_disk_encryption_set.encryption[0].id
  lock_level = "CanNotDelete"
  notes      = "Locked because it's managed by Terraform"
}