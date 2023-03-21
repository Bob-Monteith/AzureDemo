resource "azurerm_linux_virtual_machine" "virtualmachine_linux" {
  count = local.virtual_machine_linux && !var.orchestration_dry_run && !var.migration ? 1 : 0

  name                            = local.virtual_machine_name
  computer_name                   = "hostname"
  resource_group_name             = data.azurerm_resource_group.virtualmachine.name
  location                        = var.location
  size                            = var.vm_size
  admin_username                  = local.virtual_machine_username
  admin_password                  = local.virtual_machine_password
  license_type                    = local.virtual_machine_license
  zone                            = local.disk_zonal ? local.primary_zone : null
  capacity_reservation_group_id   = var.reserve_capacity == true && local.service_class ? data.azapi_resource.support_capacity_group[0].id : null
  disable_password_authentication = false
  network_interface_ids           = [azurerm_network_interface.virtualmachine[0].id]

  os_disk {
    name                 = "${local.virtual_machine_name}_OSDisk"
    caching              = "ReadWrite"
    storage_account_type = var.vm_storage_account_type
    disk_size_gb         = var.os_disk_size_gb
  }
  # add lifecycle
  source_image_id = local.management_gallery_image
  dynamic "plan" {
    for_each = local.image_plan == null ? toset([]) : toset([1])
    content {
      name      = local.image_plan
      product   = "rhel-byos"
      publisher = "redhat"
    }
  }
  tags = merge(
    local.tags, local.vmtags, local.provisioningtags
  )
  identity {
    type = "SystemAssigned"
  }
  lifecycle {
    precondition {
      condition     = local.disaster_recovery && local.production ? var.reserve_capacity : true
      error_message = format("ASSERT : You must use reserve_capacity for Production and DR Gold but set to %s", var.reserve_capacity)
    }
    precondition {
      condition     = can(regex("^(?i)(base|oracle|db2|mongodb)$", var.axavmrole))
      error_message = format("ASSERT : %s is not a valid role for %s", var.axavmrole, var.os_type)
    }
    precondition {
      condition     = var.image_template != null
      error_message = format("ASSERT : You must specify a valid image for %s", var.os_type)
    }
    precondition {
      condition     = can(regex("(?i)RHEL", var.image_template))
      error_message = format("ASSERT : %s is not a valid image for %s", var.image_template, var.os_type)
    }
    ignore_changes = [
      tags["local-vmstatus"],
      tags["local-vmprovisioning"],
      tags["local-vmpuppetstatus"],
      tags["local-vmprovisioning"],
      tags["local-vmprovisioningid"],
      tags["local-vmfqdn"],
      tags["local-workspace_runid"],
      source_image_id,
      admin_password
    ]
  }
}
