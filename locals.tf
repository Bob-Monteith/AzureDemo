# Secret main-s-rt
locals { # network
  network_resource_group_name        = format("%s%s", module.network_names.virtual_network_resource_group_name, var.network_object_index)
  virtual_network                    = format("%s%s", module.network_names.virtual_network_name, var.network_object_index)
  virtual_network_nic                = format("%s%s", module.machine_names.virtual_network_interface_name, var.object_index)
  virtual_network_subnet             = format("%s-%s-rt", lower(var.subnet_project), local.virtual_network_classification)
  virtual_network_classification     = try([for x in local.classification_data.classifications : x if x.exposure == lower(var.subnet_exposure) && x.dataclass == lower(var.global-dataclass) && x.environment == lower(var.global-env)][0].classification, "pic")
  virtual_network_address_allocation = var.private_ip_address == "0.0.0.0" ? "Dynamic" : "Static"
  virtual_network_address            = var.private_ip_address == "0.0.0.0" ? null : var.private_ip_address
}

locals { # environment
  base                     = lower(var.axavmrole) == "base" ? true : false
  production               = lower(var.global-env) == "production" ? true : false
  secret                   = lower(var.global-dataclass) == "secret" ? true : false
  backup                   = !var.orchestration_dry_run && ((lower(var.vm_backuppolicy) != "none" || local.production || local.service_class)) ? true : false
  backupresource           = lower(var.vm_backuppolicy) == "light" || lower(var.vm_backuppolicy) == "none" ? "none" : lower(var.axavmrole) == "sql" ? local.support_sql_asr : lower(var.axavmrole) == "oracle" || lower(var.axavmrole) == "db2" ? local.support_file_asr : "none"
  backupstorage            = lower(var.axavmrole) == "sql" || lower(var.vm_backuppolicy) == "light" || lower(var.vm_backuppolicy) == "none" ? "none" : lower(var.axavmrole) == "oracle" || lower(var.axavmrole) == "db2" ? local.support_file_storage_account : "none"
  workload_backup          = local.backup && can(regex("^(?i)(oracle|db2)$", var.axavmrole)) && lower(var.vm_backuppolicy) != "light" ? true : false
  service_class            = !var.orchestration_dry_run && lower(var.dr_serviceclass) != "none" ? true : false
  disaster_recovery_bronze = !var.orchestration_dry_run && lower(var.dr_serviceclass) == "bronze" ? true : false
  disaster_recovery        = !var.orchestration_dry_run && lower(var.dr_serviceclass) == "gold" ? true : false
  fixed_ip_required        = !var.orchestration_dry_run && can(regex("^(?i)(gold|bronze)$", var.dr_serviceclass)) ? true : false
  data_disk_caching        = can(regex("^(?i)(Premium_LRS|Premium_ZRS)$", var.disk_storage_account_type)) ? true : false
}
locals { # support
  support_backup_policy        = lower(var.vm_backuppolicy)
  support_backup_policy_id     = local.backup ? data.azurerm_backup_policy_vm.policy[0].id : null
  support_file_policy          = lower(var.axavmrole) == "oracle" ? local.oracle_file_policy : local.db2_file_policy
  support_key_vault            = var.app_centric.encryption_vault_name != null ? var.app_centric.encryption_vault_name : format("%s%s", module.support_names.keyvault_name, "01")
  support_automation_account   = format("%s%s", module.support_names.automation_account_name, "90")
  support_recovery_vault       = var.app_centric.replication_recovery_vault_name != null ? var.app_centric.replication_recovery_vault_name : format("%s%s", module.support_names.recovery_vault_name, "90")
  support_storage_account      = var.app_centric.replication_recovery_storage_account_name != null ? var.app_centric.replication_recovery_storage_account_name : format("%s%s", module.support_names.storage_account_name, "90")
  support_capacity_group       = var.app_centric.capacity_group_name != null ? var.app_centric.capacity_group_name : format("%s%s", module.support_names.capacity_group_name, "90")
  support_virtual_machine_asr  = var.app_centric.backup_recovery_vault_name != null ? var.app_centric.backup_recovery_vault_name : format("%s%s", module.support_names.recovery_vault_name, local.vm_policy)
  support_sql_asr              = var.app_centric.sql_recovery_vault_name != null ? var.app_centric.sql_recovery_vault_name : format("%s%s", module.support_names.recovery_vault_name, local.sql_policy)
  support_file_asr             = var.app_centric.fileshare_recovery_vault_name != null ? var.app_centric.fileshare_recovery_vault_name : format("%s%s", module.support_names.recovery_vault_name, local.support_file_policy)
  support_file_storage_account = var.app_centric.fileshare_storage_account_name != null ? var.app_centric.fileshare_storage_account_name : format("%s%s", module.support_names.storage_account_name, local.support_file_policy)
}

locals { # management
  management_subscriptionid              = data.azurerm_client_config.current.tenant_id == "d65b03ed-6a7d-41ca-a17d-4798d70d1d3f" ? "4c65da4e-36db-46e2-8f05-0a09d12d3c4c" : "3a5f4e7f-ae60-4115-b654-802a0bfd0be3"
  management_gallery_image               = var.image_template == null ? null : format("/subscriptions/%s/resourceGroups/%s/providers/Microsoft.Compute/galleries/%s/images/%s/versions/latest", local.management_subscriptionid, local.management_gallery_resource_group_name, local.management_gallery_name, var.image_template)
  management_gallery_resource_group_name = format("%s%s", module.gallery_names.resource_group_name, var.gallery_object_index)
  management_gallery_name                = format("%s%s", module.gallery_names.image_gallery_name, var.gallery_object_index)
}

locals { #virtual_machine
  virtual_machine_resource_group_name     = format("%s%s", module.group_names.resource_group_name, var.resource_group_object_index)
  virtual_machine_resource_group_name_asr = format("%s%s-asr", module.group_names.resource_group_name, var.resource_group_object_index)
  virtual_machine_name                    = format("%s%s", module.machine_names.virtual_machine_name, var.object_index)
  virtual_machine_rehosted_id             = !var.orchestration_dry_run && var.migration ? azapi_resource.virtualmachine_rehosted[0].id : null
  virtual_machine_managed_os_disk         = !var.orchestration_dry_run && local.disaster_recovery ? lower(data.azurerm_managed_disk.os_disk[0].id) : null
  virtual_machine_managed_data_disks      = !var.orchestration_dry_run && !var.migration && local.disaster_recovery ? module.vm_disks : !var.orchestration_dry_run && length(module.vm_disks) > 0 && local.disaster_recovery ? concat(module.vm_migrated_disks, module.vm_disks) : module.vm_migrated_disks
  virtual_machine_id                      = !var.orchestration_dry_run && var.migration ? local.virtual_machine_rehosted_id : local.virtual_machine_new_id
  virtual_machine_new_id                  = try(azurerm_windows_virtual_machine.virtualmachine_windows[0].id, azurerm_linux_virtual_machine.virtualmachine_linux[0].id, null)
  virtual_machine_username                = "localadm"
  virtual_machine_password                = (local.virtual_machine_windows || local.virtual_machine_linux) && !var.orchestration_dry_run && !var.migration ? random_password.password[0].result : null
  virtual_machine_license                 = lower(var.os_type) == "windows" ? "Windows_Server" : "RHEL_BYOS"
  virtual_machine_linux                   = lower(var.os_type) == "linux" ? true : false
  virtual_machine_windows                 = lower(var.os_type) == "windows" ? true : false
  virtual_machine_source                  = var.migration ? "Rehosted" : "New"
}

locals { #disks
  disk_zonal         = var.availability_zones != "0" || lower(var.dr_serviceclass) != "none" ? true : false
  availability_zone  = local.disk_zonal ? format("%s:%s", local.primary_zone, local.secondary_zone) : "0:0"
  data_disks_default = lower(var.axavmrole == "sql") ? local.data_disks_sql : lower(var.axavmrole == "oracle") ? local.data_disks_oracle : lower(var.axavmrole) == "db2" ? local.data_disks_db2 : local.data_disks_base
  data_disks         = var.migration ? var.additional_disk_configuration : flatten([local.data_disks_default, var.additional_disk_configuration])
  data_disks_count   = length(local.data_disks) + length(var.migration_data_snapshot_names)

  data_disks_base = [
    {
      name = "Data"
      size = "${var.data_disk_size}"
  }]
  data_disks_sql = [
    {
      name = "SQL_Server_Engine"
      size = 10
    },
    {
      name = "SQL_Server_Data"
      size = "${var.data_disk_size}"
  }]

  data_disks_oracle = [
    {
      name = "binaries"
      size = 30
    },
    {
      name = "dbmain"
      size = 20
    },
    {
      name = "dbdata"
      size = "${var.data_disk_size}"
    }
  ]

  data_disks_db2 = [
    {
      name = "binaries"
      size = 10
    },
    {
      name = "dbmain"
      size = 12
    },
    {
      name = "dbdata"
      size = "${var.data_disk_size}"
    }
  ]
}

locals {
  set4_support         = substr(var.support_resource_group, 14, 2)
  monitoring           = lower(var.global-env) == "production" || lower(var.global-env) == "pre-production" ? true : false
  global_windows_logs  = !var.global_monitoring || !local.monitoring ? [] : [{ name = "z-${var.global-opco}-global_windows_events_${local.set4_support}_dcr" }]
  global_linux_logs    = !var.global_monitoring || !local.monitoring ? [] : [{ name = "z-${var.global-opco}-global_linux_syslog_${local.set4_support}_dcr" }]
  local_windows_logs   = [{ name = "z-${var.global-opco}-windows_events_${local.set4_support}_dcr" }, { name = "z-${var.global-opco}-windows_perfmon_${local.set4_support}_dcr" }]
  local_linux_logs     = [{ name = "z-${var.global-opco}-linux_syslog_${local.set4_support}_dcr" }, { name = "z-${var.global-opco}-linux_perfmon_${local.set4_support}_dcr" }]
  data_collection_rule = local.virtual_machine_windows ? flatten([local.local_windows_logs, local.global_windows_logs]) : flatten([local.local_linux_logs, local.global_linux_logs])
}