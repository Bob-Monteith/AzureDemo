#   for_each = toset(var.containers)
module "vm_disks" {
  source = ".//disks"
  count  = !var.orchestration_dry_run && !var.migration ? length(local.data_disks) : 0

  vm_name                = local.virtual_machine_name
  virtual_machine_id     = local.virtual_machine_id
  resource_group_name    = data.azurerm_resource_group.virtualmachine.name
  location               = var.location
  storage_account_type   = var.disk_storage_account_type
  caching                = var.data_disk_caching
  lun                    = var.migration ? length(var.migration_data_snapshot_names) + count.index : count.index
  disk_zone              = local.disk_zonal ? local.primary_zone : null
  disk_size_gb           = local.data_disks[count.index].size
  disk_name              = local.data_disks[count.index].name
  disk_encryption_set_id = var.encryption ? azurerm_disk_encryption_set.encryption[0].id : null
  tags                   = local.tags
  depends_on             = [time_sleep.wait_10_seconds]
}

module "vm_migrated_disks" {
  source = ".//rehosted_disks"
  count  = var.migration && !var.orchestration_dry_run ? length(var.migration_data_snapshot_names) : 0

  vm_name                = local.virtual_machine_name
  resource_group_name    = data.azurerm_resource_group.virtualmachine.name
  location               = var.location
  storage_account_type   = var.disk_storage_account_type
  caching                = var.data_disk_caching
  lun                    = count.index
  disk_zone              = local.disk_zonal ? local.primary_zone : null
  disk_size_gb           = data.azurerm_snapshot.data_disk_snapshot[count.index].disk_size_gb
  disk_name              = var.migration_data_snapshot_names[count.index].name
  disk_encryption_set_id = var.encryption ? azurerm_disk_encryption_set.encryption[0].id : null
  source_resource_id     = data.azurerm_snapshot.data_disk_snapshot[count.index].id

  tags       = local.tags
  depends_on = [time_sleep.wait_10_seconds]
}

module "vm_migrated_additional_disks" {
  source = ".//rehosted_disks"
  count  = var.migration && !var.orchestration_dry_run ? length(local.data_disks) : 0

  vm_name                = local.virtual_machine_name
  resource_group_name    = data.azurerm_resource_group.virtualmachine.name
  location               = var.location
  storage_account_type   = var.disk_storage_account_type
  caching                = var.data_disk_caching
  lun                    = count.index
  disk_zone              = local.disk_zonal ? local.primary_zone : null
  disk_size_gb           = local.data_disks[count.index].size
  disk_name              = local.data_disks[count.index].name
  disk_encryption_set_id = var.encryption ? azurerm_disk_encryption_set.encryption[0].id : null
  create_option          = "Empty"
  source_resource_id     = null

  tags       = local.tags
  depends_on = [time_sleep.wait_10_seconds]
}

resource "azurerm_managed_disk" "os_disk" {
  count = var.migration && !var.orchestration_dry_run ? 1 : 0

  name                          = lower("${local.virtual_machine_name}_OSDisk")
  os_type                       = var.os_type
  create_option                 = "Copy"
  hyper_v_generation            = var.hyper_v_generation
  public_network_access_enabled = false
  zone                          = local.primary_zone
  resource_group_name           = data.azurerm_resource_group.virtualmachine.name
  location                      = var.location
  storage_account_type          = var.vm_storage_account_type
  source_resource_id            = data.azurerm_snapshot.os_disk_snapshot[0].id
  disk_size_gb                  = data.azurerm_snapshot.os_disk_snapshot[0].disk_size_gb
  network_access_policy         = "DenyAll"

  lifecycle {
    precondition {
      condition     = var.availability_zones != "0"
      error_message = format("ASSERT : Availability zones are required when migrating %s is invalid", var.availability_zones)
    }
    ignore_changes = [
      create_option,
      hyper_v_generation,
      source_resource_id
    ]
  }
  tags = local.tags
}


resource "time_sleep" "wait_10_seconds" {
  count           = (var.encryption || local.secret) && !var.orchestration_dry_run ? 1 : 0
  depends_on      = [azurerm_key_vault_access_policy.encryption-disk]
  create_duration = "10s"
}