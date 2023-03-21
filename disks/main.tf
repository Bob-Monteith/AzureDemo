resource "azurerm_managed_disk" "diskzoned" {
  count                         = var.disk_zone == 0 ? 0 : 1
  name                          = "${var.vm_name}_${var.disk_name}"
  resource_group_name           = var.resource_group_name
  location                      = var.location
  storage_account_type          = var.storage_account_type
  public_network_access_enabled = false
  create_option                 = "Empty"
  disk_size_gb                  = var.disk_size_gb
  zone                          = var.disk_zone
  disk_encryption_set_id        = var.disk_encryption_set_id
  network_access_policy         = "DenyAll"
  lifecycle {
    ignore_changes = [create_option, hyper_v_generation, source_resource_id]
  }
  tags = merge(var.tags, {
    "local-disk_name" = "${var.vm_name}_${var.disk_name}"
    "local-disk_lun"  = var.lun
  })
}

resource "azurerm_virtual_machine_data_disk_attachment" "diskzoned" {
  count              = var.disk_zone == 0 ? 0 : 1
  managed_disk_id    = azurerm_managed_disk.diskzoned[0].id
  virtual_machine_id = var.virtual_machine_id
  lun                = var.lun
  caching            = var.caching

  timeouts {
    create = "3h"
    delete = "3h"
  }
  lifecycle {
    precondition {
      condition     = var.disk_size_gb > 4095 && var.caching != "None" ? false : true
      error_message = format("ASSERT : Only Disk CachingType None is supported for disks with size greater than 4095GB %s", var.caching)
    }
  }
}

resource "azurerm_managed_disk" "disk" {
  count                         = var.disk_zone == 0 ? 1 : 0
  name                          = "${var.vm_name}_${var.disk_name}"
  resource_group_name           = var.resource_group_name
  location                      = var.location
  storage_account_type          = var.storage_account_type
  public_network_access_enabled = false
  create_option                 = "Empty"
  disk_size_gb                  = var.disk_size_gb
  disk_encryption_set_id        = var.disk_encryption_set_id
  network_access_policy         = "DenyAll"

  lifecycle {
    ignore_changes = [create_option, hyper_v_generation, source_resource_id]
  }
  tags = merge(var.tags, {
    "local-disk_name" = "${var.vm_name}_${var.disk_name}"
    "local-disk_lun"  = var.lun
  })
}

resource "azurerm_virtual_machine_data_disk_attachment" "disk" {
  count              = var.disk_zone == 0 ? 1 : 0
  managed_disk_id    = azurerm_managed_disk.disk[0].id
  virtual_machine_id = var.virtual_machine_id
  lun                = var.lun
  caching            = var.caching

  timeouts {
    create = "2h"
    delete = "2h"
  }
  lifecycle {
    precondition {
      condition     = var.disk_size_gb > 4095 && var.caching != "None"
      error_message = format("ASSERT : Only Disk CachingType None is supported for disks with size greater than 4095GB %s", var.caching)
    }
  }
}