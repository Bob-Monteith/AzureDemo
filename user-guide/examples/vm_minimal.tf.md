||||
|:--|:--|:--
|[Module Readme](https://github.axa.com/ago-sharedtferegistry/terraform-azure-vm/blob/master/README.md)|[Module User Guide](../)|[Get Support](https://confluence.axa.com/confluence/x/L49iDw)|
##
## <font color="red"><b>Using the module minimal input development windows virtual machine</b></font>
File is used to build two windows virtual machines
---
```go
module "windows_virualmachine_002" {
 source                 = "users.tfe-prod.aws-cloud.axa-de.intraxa/AGO-SharedModules/vm/azure"
 # ENVIRONMENT
 object_index           = "001"
 short_app_name         = "demo"
 # VM
 os_type                = "Windows"
 image_template         = "Windows_2019_Mutable"
 # SUPPORT
 support_resource_group = var.support_resource_group
 # NETWORK
 subnet_exposure        = var.subnet_exposure
 # TAGS
 global-dataclass       = var.global-dataclass
 global-project         = var.global-project
 global-cbp             = var.global-cbp
 global-opco            = var.global-opco
 global-app             = var.global-app
 global-dcs             = var.global-dcs
 global-appserviceid    = var.global-appserviceid
}
```