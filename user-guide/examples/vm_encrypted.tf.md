||||
|:--|:--|:--
|[Module Readme](https://github.axa.com/ago-sharedtferegistry/terraform-azure-vm/blob/master/README.md)|[Module User Guide](../)|[Get Support](https://confluence.axa.com/confluence/x/L49iDw)|
##
## <font color="red"><b>Using the module to apply customer-managed key encryption</b></font>
File is used to build a vm with encryption
https://confluence.axa.com/confluence/x/SkbJDw
---
```go
 module "windows_virualmachine_demo_encryption" {
 source               = "users.tfe-prod.aws-cloud.axa-de.intraxa/AGO-SharedModules/vm/azure"
  # insert required variables here
  short_app_name      = var.short_app_name
  object_index        = "001"
  location            = var.location
  os_type             = "Windows"
  image_template      = "Windows_2019_Mutable"
  # DEMO ENCRYPTION
  encryption          = true
  # NETWORK
  subnet_exposure     = var.subnet_exposure
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
  TFC_WORKSPACE_SLUG  = var.TFC_WORKSPACE_SLUG
}
```