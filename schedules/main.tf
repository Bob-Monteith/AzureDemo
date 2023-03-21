# shutdown_schedule
resource "azurerm_dev_test_global_vm_shutdown_schedule" "schedule" {
  virtual_machine_id    = var.virtual_machine_id
  location              = var.location
  enabled               = var.shutdown
  daily_recurrence_time = var.daily_shutdown_time
  timezone              = var.timezone
  tags                  = var.tags
  notification_settings {
    enabled = false
  }
}

