output "diskid" {
  description = "Details of the disk id"
  value       = var.disk_zone == 0 ? azurerm_managed_disk.disk[0].id : azurerm_managed_disk.diskzoned[0].id
}

output "name" {
  description = "Details of the disk name"
  value       = var.disk_zone == 0 ? azurerm_managed_disk.disk[0].name : azurerm_managed_disk.diskzoned[0].name
}