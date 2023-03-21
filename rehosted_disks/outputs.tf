output "diskid" {
  description = "Details of the disk id"
  value       = azurerm_managed_disk.diskzoned[0].id
}

output "name" {
  description = "Details of the disk id"
  value       = azurerm_managed_disk.diskzoned[0].name
}