||||
|:--|:--|:--
|[Module Readme](https://github.axa.com/ago-sharedtferegistry/terraform-azure-vm/blob/master/README.md)|[Module User Guide](../)|[Get Support](https://confluence.axa.com/confluence/x/L49iDw)|
##
## <font color="red"><b>Using the module linux virtual machine with extended fileshare</b></font>
File is used to build one linux virtual machine with fileshare
---
```go
module "windows_virtualmachine_101" {
 source                 = "users.tfe-prod.aws-cloud.axa-de.intraxa/AGO-SharedModules/vm/azure"
 # ENVIRONMENT
 short_app_name            = var.short_app_name
  object_index              = "101"
  environment_index         = var.environment_index
  network_environment_index = var.environment_index
  location                  = var.location
  os_type                   = "Linux"
  image_template            = "RHEL86_BYOS_Mutable"
  axavmrole                 = "oracle"
  # BACKUP
  vm_backuppolicy = var.vm_backuppolicy
  # NETWORK
  subnet_exposure = var.subnet_exposure
  # TAGS
  global-dataclass    = var.global-dataclass
  global-project      = var.global-project
  global-cbp          = var.global-cbp
  global-env          = var.global-env
  global-opco         = var.global-opco
  global-app          = var.global-app
  global-dcs          = var.global-dcs
  global-appserviceid = var.global-appserviceid
  # SUPPORT
  support_resource_group = var.support_resource_group
  app_centric            = {
    fileshare_recovery_vault_name = "zagopadv07en1rsv51"
    fileshare_resource_group_name = "z-ago-support-dv07-en1-01"
    fileshare_storage_account_name = "zagopadv07en1sto51"
  }
  TFC_WORKSPACE_SLUG     = var.TFC_WORKSPACE_SLUG
}

```