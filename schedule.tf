module "vm_schedule" {
  count               = !var.orchestration_dry_run ? 1 : 0
  source              = ".//schedules"
  virtual_machine_id  = local.virtual_machine_id
  location            = var.location
  shutdown            = var.enable_shutdown
  daily_shutdown_time = var.daily_shutdown_time
  timezone            = module.support_names.timezone
  tags                = local.tags
}