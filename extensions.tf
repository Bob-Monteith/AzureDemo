resource "azurerm_virtual_machine_extension" "virtualmachine_windows" {
  count                      = local.virtual_machine_windows && !var.orchestration_dry_run ? 1 : 0
  name                       = "AzureMonitorWindowsAgent"
  virtual_machine_id         = local.virtual_machine_id
  publisher                  = "Microsoft.Azure.Monitor"
  type                       = "AzureMonitorWindowsAgent"
  type_handler_version       = "1.12"
  auto_upgrade_minor_version = true
  tags                       = local.tags
}

locals {
  cmd = jsonencode(
    {
      "commandToExecute" : "powershell -ExecutionPolicy Unrestricted -Command \"& {get-disk | where {$_.PartitionStyle -eq 'RAW'} | Initialize-Disk -PartitionStyle MBR -PassThru}\"",
      "fileUris" : ""
    }
  )
}

resource "azurerm_virtual_machine_extension" "virtualmachine_initialize_windows_disks" {
  count                = local.virtual_machine_windows && !var.orchestration_dry_run && !var.migration ? 1 : 0
  name                 = "InitializeWindowsDisks"
  virtual_machine_id   = local.virtual_machine_id
  publisher            = "Microsoft.Compute"
  type                 = "CustomScriptExtension"
  type_handler_version = "1.9"
  settings             = local.cmd
  tags                 = local.tags

  depends_on = [module.vm_disks]
}


resource "time_sleep" "wait_120_seconds" {
  count           = var.migration ? 1 : 0
  create_duration = "120s"
}

resource "azurerm_virtual_machine_extension" "virtualmachine_linux" {
  count = local.virtual_machine_linux && !var.orchestration_dry_run ? 1 : 0

  name                       = "AzureMonitorLinuxAgent"
  virtual_machine_id         = local.virtual_machine_id
  publisher                  = "Microsoft.Azure.Monitor"
  type                       = "AzureMonitorLinuxAgent"
  type_handler_version       = "1.25"
  auto_upgrade_minor_version = true
  tags                       = local.tags
}
