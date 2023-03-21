
locals {
  # update to allow set of tags from the entity
  # following https://confluence.axa.com/confluence/x/2khrCg

  tags = {
    "global-opco"      = var.global-opco
    "global-dcs"       = var.global-dcs
    "global-env"       = var.global-env       # API environment
    "global-dataclass" = var.global-dataclass # API exposure and dataclass make dataclass
    "global-cbp"       = var.global-cbp
    "global-project"   = var.global-project
    "global-app"       = var.global-app # API appname
  }

  vmtags = {
    "global-appserviceid" = var.global-appserviceid
    "local-configuration" = jsonencode({
      exposure          = var.subnet_exposure # API exposure and dataclass make dataclass
      routable          = true                # API axaroutable
      availability_zone = var.availability_zone
      axavmrole         = var.axavmrole # API vm_role
    })
    "local-deployment" = jsonencode({
      workspace_slug = var.workspace_slug
    })
    "local-purpose"        = "MPI" # used for policy compliance.
    "local-vmostype"       = var.os_type
    "local-vmdrclass"      = var.dr_serviceclass
    "local-vmbackuppolicy" = var.vmbackuppolicy
    "local-orchestration"  = var.orchestration
  }

  provisioningtags = {
    # this needs to be removed for a migration case?
    "local-vmsource"        = var.vmsource
    "local-workspace_runid" = var.workspace_runid
  }
}
