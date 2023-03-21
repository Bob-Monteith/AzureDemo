locals {
  policy_data         = jsondecode(file("${path.module}/lookups/policies.json"))
  zone_data           = jsondecode(file("${path.module}/lookups/zones.json"))
  linux_data          = jsondecode(file("${path.module}/lookups/images.json"))
  classification_data = jsondecode(file("${path.module}/lookups/classifications.json"))
  version_data        = jsondecode(file("${path.module}/lookups/version.json"))
  vm_policy           = [for x in local.policy_data.vm_policies : x if x.policy == local.support_backup_policy][0].index
  sql_policy          = [for x in local.policy_data.sql_policies : x if x.policy == local.support_backup_policy][0].index
  oracle_file_policy  = [for x in local.policy_data.oracle_file_policies : x if x.policy == local.support_backup_policy][0].index
  db2_file_policy     = [for x in local.policy_data.db_file_policies : x if x.policy == local.support_backup_policy][0].index
  image_plan          = can(regex("(?i)(BYOS)", var.image_template)) ? [for x in local.linux_data.images : x if x.name == var.image_template][0].plan : null
  primary_zone        = local.disk_zonal ? [for x in local.zone_data.primary_zones : x if x.option == var.availability_zones][0].zone : 0
  secondary_zone      = local.disk_zonal ? [for x in local.zone_data.secondary_zones : x if x.option == var.availability_zones][0].zone : 0
  module_version      = local.version_data.version
}
