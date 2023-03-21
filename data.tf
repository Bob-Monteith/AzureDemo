data "azurerm_resource_group" "supportmodule" {
  name = var.support_resource_group
  lifecycle {
    postcondition {
      condition     = self.id != null
      error_message = format("ASSERT : You must have support module deployed resource group %s not found", var.support_resource_group)
    }
  }
}
data "azurerm_client_config" "current" {
}

data "azurerm_resource_group" "virtualmachine" {
  name = local.virtual_machine_resource_group_name
}

data "azurerm_key_vault" "support" {
  count               = var.encryption ? 1 : 0
  name                = local.support_key_vault
  resource_group_name = var.app_centric.encryption_resource_group_name != null ? var.app_centric.encryption_resource_group_name : var.support_resource_group
}

# ASR Data
data "azurerm_resource_group" "virtualmachine_asr" {
  count = local.disaster_recovery ? 1 : 0
  name  = local.virtual_machine_resource_group_name_asr
  lifecycle {
    postcondition {
      condition     = self.id != null
      error_message = format("ASSERT : You must have asr resource group %s", local.virtual_machine_resource_group_name_asr)
    }
  }
}
data "azurerm_storage_account" "primary" {
  count               = local.disaster_recovery ? 1 : 0
  name                = local.support_storage_account
  resource_group_name = var.app_centric.replication_resource_group_name != null ? var.app_centric.replication_resource_group_name : var.support_resource_group
}

data "azurerm_site_recovery_replication_policy" "policy" {
  count               = local.disaster_recovery ? 1 : 0
  name                = "primary-policy"
  recovery_vault_name = local.support_recovery_vault
  resource_group_name = var.app_centric.replication_resource_group_name != null ? var.app_centric.replication_resource_group_name : var.support_resource_group
}

data "azurerm_site_recovery_fabric" "fabric" {
  count               = local.disaster_recovery ? 1 : 0
  name                = "primary-fabric"
  recovery_vault_name = local.support_recovery_vault
  resource_group_name = var.app_centric.replication_resource_group_name != null ? var.app_centric.replication_resource_group_name : var.support_resource_group
}

data "azurerm_site_recovery_protection_container" "primary" {
  count                = local.disaster_recovery ? 1 : 0
  name                 = "primary-protection-container"
  recovery_vault_name  = local.support_recovery_vault
  resource_group_name  = var.app_centric.replication_resource_group_name != null ? var.app_centric.replication_resource_group_name : var.support_resource_group
  recovery_fabric_name = "primary-fabric"
}

data "azurerm_site_recovery_protection_container" "secondary" {
  count                = local.disaster_recovery ? 1 : 0
  name                 = "secondary-protection-container"
  recovery_vault_name  = local.support_recovery_vault
  resource_group_name  = var.app_centric.replication_resource_group_name != null ? var.app_centric.replication_resource_group_name : var.support_resource_group
  recovery_fabric_name = "primary-fabric"
}

data "azurerm_managed_disk" "os_disk" {
  count               = local.disaster_recovery ? 1 : 0
  name                = "${local.virtual_machine_name}_OSDisk"
  resource_group_name = local.virtual_machine_resource_group_name
  depends_on = [
    azurerm_windows_virtual_machine.virtualmachine_windows, azapi_resource.virtualmachine_rehosted, azurerm_linux_virtual_machine.virtualmachine_linux
  ]
}
data "azurerm_managed_disk" "rehosted_disks" {
  count               = var.migration ? length(var.migration_data_snapshot_names) : 0
  name                = "${local.virtual_machine_name}_${var.migration_data_snapshot_names[count.index].name}"
  resource_group_name = local.virtual_machine_resource_group_name
  depends_on = [
    module.vm_migrated_disks
  ]
}

data "azurerm_managed_disk" "rehosted_additional_data_disks" {
  count               = var.migration ? length(local.data_disks) : 0
  name                = "${local.virtual_machine_name}_${local.data_disks[count.index].name}"
  resource_group_name = local.virtual_machine_resource_group_name
  depends_on = [
    module.vm_migrated_additional_disks
  ]
}

# Data source definition of the subnet
data "azurerm_resource_group" "vnet" {
  name = local.network_resource_group_name
}

data "azurerm_virtual_network" "vnet" {
  name                = local.virtual_network
  resource_group_name = data.azurerm_resource_group.vnet.name
}

data "azurerm_subnet" "subnet" {
  name                 = local.virtual_network_subnet
  virtual_network_name = data.azurerm_virtual_network.vnet.name
  resource_group_name  = data.azurerm_resource_group.vnet.name
}

data "azurerm_resource_group" "snapshots" {
  count = var.migration ? 1 : 0
  name  = var.migration_resource_group
  lifecycle {
    postcondition {
      condition     = self.id != null
      error_message = format("ASSERT : You must have migration resource group %s", var.migration_resource_group)
    }
  }
}

data "azurerm_snapshot" "os_disk_snapshot" {
  count               = var.migration ? 1 : 0
  name                = var.migration_os_snapshot_name
  resource_group_name = data.azurerm_resource_group.snapshots[0].name
}

data "azurerm_snapshot" "data_disk_snapshot" {
  count               = length(var.migration_data_snapshot_names)
  name                = var.migration_data_snapshot_names[count.index].name
  resource_group_name = data.azurerm_resource_group.snapshots[0].name
}

# backup
data "azurerm_recovery_services_vault" "vault" {
  count               = local.backup ? 1 : 0
  name                = local.support_virtual_machine_asr
  resource_group_name = var.app_centric.backup_resource_group_name != null ? var.app_centric.backup_resource_group_name : var.support_resource_group
}
data "azurerm_recovery_services_vault" "filevault" {
  count               = local.workload_backup && local.virtual_machine_linux ? 1 : 0
  name                = local.support_file_asr
  resource_group_name = var.app_centric.fileshare_resource_group_name != null ? var.app_centric.fileshare_resource_group_name : var.support_resource_group
}

data "azurerm_backup_policy_vm" "policy" {
  count               = local.backup ? 1 : 0
  name                = local.support_backup_policy
  recovery_vault_name = data.azurerm_recovery_services_vault.vault[0].name
  resource_group_name = data.azurerm_recovery_services_vault.vault[0].resource_group_name
  lifecycle {
    precondition {
      condition     = local.service_class ? can(regex("^(?i)(light|basic|medium|intermediate|enhanced)$", var.vm_backuppolicy)) : true
      error_message = format("ASSERT : DR virtual Machines must be backed up policy %s is invalid", var.vm_backuppolicy)
    }
  }
}

data "azurerm_backup_policy_file_share" "filepolicy" {
  count               = local.workload_backup && local.virtual_machine_linux ? 1 : 0
  name                = local.support_backup_policy
  recovery_vault_name = data.azurerm_recovery_services_vault.filevault[0].name
  resource_group_name = data.azurerm_recovery_services_vault.filevault[0].resource_group_name
  lifecycle {
    precondition {
      condition     = !local.base ? can(regex("^(?i)(basic|medium|intermediate|enhanced)$", var.vm_backuppolicy)) : true
      error_message = format("ASSERT : %s Virtual Machine must be backed up with a valid policy %s is invalid", var.axavmrole, var.vm_backuppolicy)
    }
  }
}

data "azurerm_storage_account" "filesupport" {
  count               = local.workload_backup && local.virtual_machine_linux ? 1 : 0
  name                = local.support_file_storage_account
  resource_group_name = var.app_centric.fileshare_resource_group_name != null ? var.app_centric.fileshare_resource_group_name : var.support_resource_group
  lifecycle {
    precondition {
      condition     = !local.base ? can(regex("^(?i)(basic|medium|intermediate|enhanced)$", var.vm_backuppolicy)) : true
      error_message = format("ASSERT : %s Virtual Machine must be backed up with a valid policy %s is invalid", var.axavmrole, var.vm_backuppolicy)
    }
  }
}

data "azurerm_resource_group" "capacity_group" {
  count = var.reserve_capacity && var.app_centric.capacity_resource_group_name != null ? 1 : 0
  name  = var.app_centric.capacity_resource_group_name
}

data "azapi_resource" "support_capacity_group" {
  count     = var.reserve_capacity && local.service_class ? 1 : 0
  name      = local.support_capacity_group
  parent_id = var.app_centric.capacity_resource_group_name != null ? data.azurerm_resource_group.capacity_group[0].id : data.azurerm_resource_group.supportmodule.id
  type      = "Microsoft.Compute/capacityReservationGroups@2021-11-01"
  lifecycle {
    postcondition {
      condition     = self.id != null
      error_message = format("ASSERT : You must have reserve_capacity group deployed via support module")
    }
  }
}
/*
data "azurerm_capacity_reservation_group" "support_capacity_group" {
  name      = local.support_capacity_group
  resource_group_name = var.support_resource_group
  location            = var.location
}
*/