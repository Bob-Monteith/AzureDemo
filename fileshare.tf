resource "azurerm_storage_share" "filesupport" {
  count                = local.workload_backup && !var.orchestration_dry_run && local.virtual_machine_linux ? 1 : 0
  name                 = local.virtual_machine_name
  quota                = var.file_share_quota
  storage_account_name = data.azurerm_storage_account.filesupport[0].name
  lifecycle {
    precondition {
      condition     = !local.base ? can(regex("^(?i)(basic|medium|intermediate|enhanced)$", var.vm_backuppolicy)) : true
      error_message = format("ASSERT : %s Virtual Machine must be backed up with a valid policy %s is invalid", var.axavmrole, var.vm_backuppolicy)
    }
    precondition {
      condition     = var.file_share_quota > 5120 ? (var.app_centric.fileshare_storage_account_name != null && var.app_centric.fileshare_resource_group_name != null) : true
      error_message = format("ASSERT : Resource Group fileshare_resource_group_name and storage fileshare_storage_account_name must be provided for a large fileshare")
    }
    precondition {
      condition     = local.secret ? (var.app_centric.fileshare_storage_account_name != null && var.app_centric.fileshare_resource_group_name != null) : true
      error_message = format("ASSERT : Resource Group fileshare_resource_group_name and storage fileshare_storage_account_name must be provided for a secret fileshare")
    }
  }
}

resource "azurerm_storage_share_file" "filesupport" {
  count            = local.workload_backup && !var.orchestration_dry_run && local.virtual_machine_linux ? 1 : 0
  name             = "readme.txt"
  source           = "${path.module}/readme.txt"
  storage_share_id = azurerm_storage_share.filesupport[0].id
  lifecycle {
    precondition {
      condition     = !local.base ? can(regex("^(?i)(basic|medium|intermediate|enhanced)$", var.vm_backuppolicy)) : true
      error_message = format("ASSERT : %s Virtual Machine must be backed up with a valid policy %s is invalid", var.axavmrole, var.vm_backuppolicy)
    }
  }
}
resource "azurerm_backup_protected_file_share" "filesupport" {
  count                     = local.workload_backup && !var.orchestration_dry_run && local.virtual_machine_linux ? 1 : 0
  resource_group_name       = data.azurerm_storage_account.filesupport[0].resource_group_name
  recovery_vault_name       = data.azurerm_recovery_services_vault.filevault[0].name
  source_file_share_name    = azurerm_storage_share.filesupport[0].name
  source_storage_account_id = data.azurerm_storage_account.filesupport[0].id
  backup_policy_id          = data.azurerm_backup_policy_file_share.filepolicy[0].id
  lifecycle {
    precondition {
      condition     = !local.base ? can(regex("^(?i)(basic|medium|intermediate|enhanced)$", var.vm_backuppolicy)) : true
      error_message = format("ASSERT : %s Virtual Machine must be backed up with a valid policy %s is invalid", var.axavmrole, var.vm_backuppolicy)
    }
  }
}