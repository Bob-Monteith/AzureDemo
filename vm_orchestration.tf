module "orchestration_run" { #can we make sure the vm exists. local.virtual_machine_id
  source              = ".//orchestration_run"
  count               = (var.orchestration_dry_run && !var.orchestration_re_run) || (var.orchestration_re_run && !var.orchestration_dry_run) ? 1 : 0
  mode                = var.orchestration_dry_run ? "dry-run" : "re-run"
  resource_group_name = data.azurerm_resource_group.virtualmachine.name
  location            = var.location
  # tags used
  global-opco         = var.global-opco
  global-dcs          = var.global-dcs
  global-env          = var.global-env
  global-dataclass    = var.global-dataclass
  global-cbp          = var.global-cbp
  global-project      = var.global-project
  global-app          = var.global-app
  global-appserviceid = var.global-appserviceid
  # machine
  virtual_machine_name = local.virtual_machine_name
  vmsource             = local.virtual_machine_source
  # network
  subnet_exposure    = var.subnet_exposure
  private_ip_address = var.private_ip_address
  # disks
  availability_zone = var.availability_zones
  # OS
  axavmrole = var.axavmrole
  os_type   = var.os_type
  # backup and dr
  dr_serviceclass = var.dr_serviceclass
  vmbackuppolicy  = var.vm_backuppolicy
  # deployment
  workspace_slug  = var.TFC_WORKSPACE_SLUG
  workspace_runid = var.TFC_RUN_ID
}