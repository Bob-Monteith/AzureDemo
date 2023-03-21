# can we replace with Microsoft.Compute/virtualMachines@2021-11-01
# https://docs.microsoft.com/en-us/azure/templates/microsoft.compute/2021-11-01/virtualmachines?tabs=bicep
locals {
  json_disks = [for index, disk in flatten([data.azurerm_managed_disk.rehosted_disks, data.azurerm_managed_disk.rehosted_additional_data_disks]) : {
    createOption = "Attach"
    name         = disk.name
    lun          = index
    caching      = var.data_disk_caching
    managedDisk = {
      id                 = disk.id
      storageAccountType = var.disk_storage_account_type
    }
    }
  ]
  hosted_data_disks = local.json_disks
}
resource "azapi_resource" "virtualmachine_rehosted" {
  count = var.migration && !var.orchestration_dry_run ? 1 : 0
  type  = "Microsoft.Compute/virtualMachines@2022-11-01"

  name      = local.virtual_machine_name
  location  = var.location
  parent_id = data.azurerm_resource_group.virtualmachine.id
  body = jsonencode({
    identity = {
      type = "SystemAssigned"
    }
    properties = {
      hardwareProfile = {
        vmSize = var.vm_size
      }
      networkProfile = {
        networkInterfaces = [{
          id = azurerm_network_interface.virtualmachine[0].id
        }]
      }
      storageProfile = {
        osDisk = {
          createOption = "Attach"
          managedDisk = {
            storageAccountType = var.vm_storage_account_type
            id                 = azurerm_managed_disk.os_disk[0].id
          }
          osType = var.os_type
          name   = azurerm_managed_disk.os_disk[0].name
        }
        dataDisks = local.hosted_data_disks
      }
      capacityReservation = {
        capacityReservationGroup = {
          id = var.reserve_capacity == true && local.service_class ? data.azapi_resource.support_capacity_group[0].id : null
        }
      }
      licenseType = local.virtual_machine_license
    }
    zones = ["${local.primary_zone}"]
  })
  schema_validation_enabled = false
  tags                      = merge(local.tags, local.vmtags, local.provisioningtags)
  lifecycle {
    precondition {
      condition     = local.data_disk_caching ? can(regex("^(?i)(Premium_LRS|Premium_ZRS)$", var.disk_storage_account_type)) : true
      error_message = format("ASSERT : You cannot use disk caching with none premium storage %s", var.disk_storage_account_type)
    }
    precondition {
      condition     = local.disaster_recovery && local.production ? var.reserve_capacity : true
      error_message = format("ASSERT : You must use reserve_capacity for Production and DR Gold but set to %s", var.reserve_capacity)
    }
    precondition {
      condition     = can(regex("^(?i)(bronze|platinum|gold)$", var.dr_serviceclass))
      error_message = format("ASSERT : DR service class is required when migrating %s is invalid", var.dr_serviceclass)
    }
    precondition {
      condition     = var.image_template == null
      error_message = format("ASSERT : image_template cannot be used when migrating %s", var.os_type)
    }
    precondition {
      condition     = var.availability_zones != "0"
      error_message = format("ASSERT : Availability zones are required when migrating %s is invalid", var.availability_zones)
    }
    ignore_changes = [
      tags["local-vmstatus"],
      tags["local-vmprovisioning"],
      tags["local-vmpuppetstatus"],
      tags["local-vmprovisioning"],
      tags["local-vmprovisioningid"],
      tags["local-vmfqdn"],
      tags["local-workspace_runid"]
    ]
  }
}