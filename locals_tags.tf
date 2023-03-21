locals {
  vnet_tag = {
    "mpi-exposure" = var.subnet_exposure
  }
}

locals {
  # update to allow set of tags from the entity
  # following https://confluence.axa.com/confluence/x/2khrCg

  tags = merge(var.custom_tags, {
    "global-opco"          = var.global-opco # API opco
    "global-dcs"           = var.global-dcs
    "global-env"           = var.global-env       # API environment
    "global-dataclass"     = var.global-dataclass # API exposure and dataclass make dataclass
    "global-cbp"           = var.global-cbp
    "global-project"       = var.global-project
    "global-app"           = var.global-app # API appname
    "global-techserviceid" = module.support_names.techserviceid
    "global-appserviceid"  = var.global-appserviceid
  })

  vmtags = {
    "local-configuration" = jsonencode({
      exposure          = lower(var.subnet_exposure) # API exposure and dataclass make dataclass
      routable          = "true"                     # API axaroutable
      availability_zone = local.availability_zone
      axavmrole         = var.axavmrole    # API vm_role
      puppetbranch      = var.puppetbranch # API puppet branch
      data_disks        = local.data_disks_count
      data_disksize     = var.data_disk_size # Used for puppet
    })
    "local-deployment" = jsonencode({
      workspace_slug = var.TFC_WORKSPACE_SLUG
      moduleversion  = local.module_version
    })
    # these need to be simplified using too many tags.
    "local-purpose"            = "MPI" # used for policy compliance.
    "local-vmrole"             = var.axavmrole
    "local-vmostype"           = var.os_type
    "local-vmdrclass"          = var.dr_serviceclass
    "local-vmbackuppolicy"     = local.support_backup_policy
    "local-vmbackupvault"      = local.support_virtual_machine_asr
    "local-backupresource"     = local.backupresource
    "local-backupshare"        = local.support_file_storage_account
    "local-backupsharerg"      = var.app_centric.fileshare_resource_group_name != null ? var.app_centric.fileshare_resource_group_name : var.support_resource_group
    "local-vmsupportrg"        = var.support_resource_group
    "local-backupsql"          = local.support_sql_asr
    "local-backupsqlrg"        = var.app_centric.sql_resource_group_name != null ? var.app_centric.sql_resource_group_name : var.support_resource_group
    "local-licensetype"        = local.virtual_machine_license
    "local-orchestration"      = var.orchestration
    "local-notification_email" = var.notification_email
  }

  provisioningtags = {
    # this needs to be removed for a migration case?
    "local-vmsource"          = local.virtual_machine_source
    "local-vmstatus"          = "NotReady"
    "local-vmfqdn"            = "NotReady"
    "local-vmprovisioning"    = "NotReady"
    "local-vmpuppetstatus"    = "NotReady"
    "local-vmprovisioningid"  = "NotReady"
    "local-silva_internal_id" = "NotReady"
    "local-workspace_runid"   = var.TFC_RUN_ID
  }
}
