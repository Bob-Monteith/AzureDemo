||||
|:--|:--|:--
|[Module Readme](https://github.axa.com/ago-sharedtferegistry/terraform-azure-vm/blob/master/README.md)|[Module User Guide](../)|[Get Support](https://confluence.axa.com/confluence/x/L49iDw)|
##
## <font color="red"><b>Using the module re-hosting a virtual machine</b></font>
File is used to build a re-hosted virtual machine
---
```go
module "windows_virualmachine_demo_rehosted1" {
 source                         = "users.tfe-prod.aws-cloud.axa-de.intraxa/AGO-SharedModules/vm/azure"
 # ENVIRONMENT
 object_index                   = "201"
 short_app_name                 = var.short_app_name
 environment_index              = var.environment_index
 # VM
 location                       = var.location
 vm_size                        = var.vm_size
 os_type                        = "Windows"
 # DEMO MIGRATION
 migration                       = true
 migration_os_snapshot_name      = "zagomigrateddv01002_OSDisk_SnapShot"
 migration_data_snapshot_names   = [{name = "zagomigrateddv01002_Data_SnapShot"}]
 migration_resource_group        = "z-ago-demomigration-dv01-en1-01"
 hybrid_benefit                  = "Windows_Server"
 # SUPPORT
 support_resource_group         = var.support_resource_group
 # NETWORK
 subnet_exposure                = var.subnet_exposure
 # TAGS
 global-dataclass               = var.global-dataclass
 global-project                 = var.global-project
 global-cbp                     = var.global-cbp
 global-env                     = var.global-env
 global-opco                    = var.global-opco
 global-app                     = var.global-app
 global-dcs                     = var.global-dcs
 global-appserviceid            = var.global-appserviceid
 # AUTH
 TFC_WORKSPACE_SLUG             = var.TFC_WORKSPACE_SLUG
}
```