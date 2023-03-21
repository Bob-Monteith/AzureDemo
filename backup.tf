/*
resource "azurerm_backup_protected_vm" "protected_intent" {
  count               = (local.backup || local.production) && !var.orchestration_dry_run ? 1 : 0
  resource_group_name = data.azurerm_recovery_services_vault.vault[0].resource_group_name
  recovery_vault_name = data.azurerm_recovery_services_vault.vault[0].name
  source_vm_id        = data.azurerm_resource_group.virtualmachine.id
  backup_policy_id    = local.support_backup_policy_id
}
*/
resource "azapi_resource" "protected_intent" {
  count     = (local.backup || local.production) && !var.orchestration_dry_run ? 1 : 0
  type      = "Microsoft.RecoveryServices/vaults/backupFabrics/backupProtectionIntent@2023-01-01"
  name      = format("vm;iaasvmcontainerv2;%s;%s", data.azurerm_resource_group.virtualmachine.name, local.virtual_machine_name)
  location  = var.location
  parent_id = format("%s%s", data.azurerm_recovery_services_vault.vault[0].id, "/backupFabrics/Azure")

  body = jsonencode({
    properties = {
      backupManagementType     = "AzureIaasVM"
      policyId                 = local.support_backup_policy_id
      sourceResourceId         = local.virtual_machine_id
      protectionIntentItemType = "AzureResourceItem"
    }
  })
  lifecycle {
    /*
    precondition {
      condition     = local.secret ? can(regex("^(?i)(medium|intermediate|enhanced)$", var.vm_backuppolicy)) : true
      error_message = format("ASSERT : Secret virtual Machines must be backed up policy medium|intermediate|enhanced %s is invalid", var.vm_backuppolicy)
    }
  */
    precondition {
      condition     = local.disaster_recovery_bronze ? can(regex("^(?i)(light|basic|medium|intermediate|enhanced)$", var.vm_backuppolicy)) : true
      error_message = format("ASSERT : DR virtual Machines must be backed up policy %s is invalid", var.vm_backuppolicy)
    }
    precondition {
      condition     = local.production ? can(regex("^(?i)(basic|medium|intermediate|enhanced)$", var.vm_backuppolicy)) : true
      error_message = format("ASSERT : Production Virtual Machine must be backed up policy %s is invalid", var.vm_backuppolicy)
    }
    precondition {
      condition     = !local.production ? can(regex("^(?i)(light|basic|medium|intermediate|enhanced)$", var.vm_backuppolicy)) : true
      error_message = format("ASSERT : %s Virtual Machine must be backed up with a valid policy %s is invalid", var.axavmrole, var.vm_backuppolicy)
    }
    ignore_changes = [
      location
    ]
  }
}