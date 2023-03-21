resource "azurerm_site_recovery_replicated_vm" "protected_vm_tf" {
  count                                     = local.disaster_recovery && !var.orchestration_dry_run ? 1 : 0
  name                                      = local.virtual_machine_name
  recovery_vault_name                       = var.app_centric.replication_recovery_vault_name != null ? var.app_centric.replication_recovery_vault_name : local.support_recovery_vault
  resource_group_name                       = var.app_centric.replication_resource_group_name != null ? var.app_centric.replication_resource_group_name : var.support_resource_group
  recovery_replication_policy_id            = data.azurerm_site_recovery_replication_policy.policy[0].id
  source_vm_id                              = local.virtual_machine_id
  source_recovery_fabric_name               = data.azurerm_site_recovery_fabric.fabric[0].name
  source_recovery_protection_container_name = data.azurerm_site_recovery_protection_container.primary[0].name
  target_zone                               = local.secondary_zone
  target_resource_group_id                  = data.azurerm_resource_group.virtualmachine_asr[0].id
  target_recovery_fabric_id                 = data.azurerm_site_recovery_fabric.fabric[0].id
  target_recovery_protection_container_id   = data.azurerm_site_recovery_protection_container.secondary[0].id
  target_network_id                         = data.azurerm_virtual_network.vnet.id
  target_capacity_reservation_group_id      = var.reserve_capacity == true && local.service_class ? data.azapi_resource.support_capacity_group[0].id : null

  managed_disk {
    disk_id                       = local.virtual_machine_managed_os_disk
    staging_storage_account_id    = data.azurerm_storage_account.primary[0].id
    target_resource_group_id      = data.azurerm_resource_group.virtualmachine_asr[0].id
    target_disk_type              = var.disk_storage_account_type
    target_replica_disk_type      = var.disk_storage_account_type
    target_disk_encryption_set_id = var.encryption ? azurerm_disk_encryption_set.encryption[0].id : null
  }

  dynamic "managed_disk" {
    for_each = local.virtual_machine_managed_data_disks
    content {
      disk_id                       = lower(managed_disk.value.diskid)
      staging_storage_account_id    = data.azurerm_storage_account.primary[0].id
      target_resource_group_id      = data.azurerm_resource_group.virtualmachine_asr[0].id
      target_disk_type              = var.disk_storage_account_type
      target_replica_disk_type      = var.disk_storage_account_type
      target_disk_encryption_set_id = var.encryption ? azurerm_disk_encryption_set.encryption[0].id : null
    }
  }

  network_interface {
    source_network_interface_id = azurerm_network_interface.virtualmachine[0].id
    target_subnet_name          = data.azurerm_subnet.subnet.name
    target_static_ip            = local.virtual_network_address
  }
  timeouts {
    create = "8h"
    update = "8h"
    delete = "8h"
  }

  lifecycle {
    precondition {
      condition     = var.availability_zones != "0"
      error_message = format("ASSERT : Availability zones are required for DR %s is invalid", var.availability_zones)
    }
    precondition {
      condition     = var.private_ip_address != "0.0.0.0"
      error_message = format("ASSERT : You must use a valid static IP %s is invalid", var.private_ip_address)
    }
    ignore_changes = [
      managed_disk
    ]
  }
}