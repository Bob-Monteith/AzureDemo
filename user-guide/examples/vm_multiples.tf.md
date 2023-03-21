||||
|:--|:--|:--
|[Module Readme](https://github.axa.com/ago-sharedtferegistry/terraform-azure-vm/blob/master/README.md)|[Module User Guide](../)|[Get Support](https://confluence.axa.com/confluence/x/L49iDw)|
##
## <font color="red"><b>Using the module and for_each to build multiple virtual machines</b></font>
File is used to build multiple windows virtual machines
---
```go
module "windows_virualmachine_001" {
 for_each               = toset(["401", "402", "403", "404"])

 source                 = "users.tfe-prod.aws-cloud.axa-de.intraxa/AGO-SharedModules/vm/azure"
 # ENVIRONMENT
 object_index           = each.key
 short_app_name         = var.short_app_name
 environment_index      = var.environment_index
 # VM
 location               = var.location
 vm_size                = var.vm_size
 os_type                = "Windows"
 image_template         = "Windows_2019_Mutable"
 # DR & HA
 dr_serviceclass        = var.dr_serviceclass
 vm_backuppolicy        = var.vm_backuppolicy
 # SUPPORT
 support_resource_group = var.support_resource_group
 # NETWORK
 subnet_exposure        = var.subnet_exposure
 # TAGS
 global-dataclass       = var.global-dataclass
 global-project         = var.global-project
 global-cbp             = var.global-cbp
 global-env             = var.global-env
 global-opco            = var.global-opco
 global-app             = var.global-app
 global-dcs             = var.global-dcs
 global-appserviceid    = var.global-appserviceid
 # AUTH
 TFC_WORKSPACE_SLUG     = var.TFC_WORKSPACE_SLUG
}
```