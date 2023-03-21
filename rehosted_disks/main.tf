resource "azurerm_managed_disk" "diskzoned" {
  count                         = var.disk_zone == 0 ? 0 : 1
  name                          = "${var.vm_name}_${var.disk_name}"
  resource_group_name           = var.resource_group_name
  location                      = var.location
  storage_account_type          = var.storage_account_type
  public_network_access_enabled = false
  create_option                 = var.create_option
  disk_size_gb                  = var.disk_size_gb
  zone                          = var.disk_zone
  disk_encryption_set_id        = var.disk_encryption_set_id
  source_resource_id            = var.source_resource_id
  network_access_policy         = "DenyAll"
  lifecycle {
    ignore_changes = [
      disk_size_gb,
      create_option,
      hyper_v_generation
    ]
  }
  tags = merge(var.tags, {
    "local-disk_name" = "${var.vm_name}_${var.disk_name}"
    "local-disk_lun"  = var.lun
  })
}