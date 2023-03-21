resource "random_password" "password" {
  count            = (local.virtual_machine_windows || local.virtual_machine_linux) && !var.orchestration_dry_run && !var.migration ? 1 : 0
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
  min_lower        = 1
  min_numeric      = 1
  min_special      = 1
  min_upper        = 1
}